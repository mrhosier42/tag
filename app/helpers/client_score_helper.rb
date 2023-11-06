module ClientScoreHelper
      SPRINT_PATTERN = /\Aq3\z/i
      TEAM_PATTERN = /\Aq1_team\z/i
      PERFORMANCE_PATTERN = /\Aq2_\d+\z/i

      def performance_to_score(response)
        response = response.to_s.downcase
        case response
        when "exceeded expectations" then 3.0
        when "met expectations" then 2.0
        when "did not meet expectations" then 1.0
        else 0.0
        end
      end

      def calculate_score(matching_row, performance_columns)
        performance_scores = performance_columns.map do |col|
          response = matching_row[col]
          performance_to_score(response)
        end
        performance_average = performance_scores.sum / performance_scores.size
        performance_average.round(1)
      end
      
      def get_client_score(semester, team, sprint)
        similarity_threshold = 0.1  # Adjust this for team matching as needed
        
        semester.client_csv.open do |tempfile|
          begin
            table = CSV.read(tempfile.path, headers: true)
            performance_columns = table.headers.select { |header| header.match?(PERFORMANCE_PATTERN) }
            sprint_column = table.headers.find { |header| header.match?(SPRINT_PATTERN) }
            team_column = table.headers.find { |header| header.match?(TEAM_PATTERN) }
            
            best_match = nil
            smallest_distance = Float::INFINITY
      
            table.each do |row|
              # First, match sprints exactly to avoid sprint confusion
              next unless row[sprint_column].to_s.strip.downcase == sprint.strip.downcase
      
              # Calculate Levenshtein distance for team names
              team_distance = Levenshtein.distance(row[team_column].to_s.strip.downcase, team.strip.downcase).to_f / [row[team_column].to_s.length, team.length].max
              
              if team_distance < smallest_distance && team_distance < similarity_threshold
                smallest_distance = team_distance
                best_match = row
              end
            end
            
            unless best_match
              Rails.logger.debug "No Matching Row Found for Sprint: #{sprint}"
              return "No Score"
            end
            
            Rails.logger.debug "Best Matching Row Found for Sprint: #{sprint}: #{best_match}"
            performance_average = calculate_score(best_match, performance_columns)
            performance_average
            
          rescue => exception
            Rails.logger.error("Error processing CSV: #{exception.message}")
            "Error! Unable to read sponsor data."
          end    
        end      
      end
    end