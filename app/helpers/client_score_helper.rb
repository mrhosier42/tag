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
        similarity_threshold = 0.1  # You can adjust this threshold as needed
        
        semester.client_csv.open do |tempfile|
          begin
            table = CSV.read(tempfile.path, headers: true)
            performance_columns = table.headers.select { |header| header.match?(PERFORMANCE_PATTERN) }
            sprint_column = table.headers.find { |header| header.match?(SPRINT_PATTERN) }
            team_column = table.headers.find { |header| header.match?(TEAM_PATTERN) }
            
            best_match = nil
            smallest_distance = Float::INFINITY
      
            table.each do |row|
              sprint_distance = Levenshtein.distance(row[sprint_column].to_s.strip.downcase, sprint.strip.downcase).to_f / [row[sprint_column].to_s.length, sprint.length].max
              team_distance = Levenshtein.distance(row[team_column].to_s.strip.downcase, team.strip.downcase).to_f / [row[team_column].to_s.length, team.length].max
              
              average_distance = (sprint_distance + team_distance) / 2
              if average_distance < smallest_distance && average_distance < similarity_threshold
                smallest_distance = average_distance
                Rails.logger.debug("BUG row: #{row}")
                best_match = row
              end
              ""
            end
            
            unless best_match
              Rails.logger.debug "No Matching Row Found"
              return "No Score"
            end
            
            Rails.logger.debug "Best Matching Row Found: #{best_match}"
            performance_average = calculate_score(best_match, performance_columns)
            performance_average
            
          rescue => exception
            Rails.logger.error("Error processing CSV: #{exception.message}")
            "Error! Unable to read sponsor data."
          end    
        end      
    end
end

  