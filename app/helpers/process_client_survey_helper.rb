module ProcessClientSurveyHelper

  # def process_client_data_for_scores(sponsor_data, team, sprint)
  #   sponsor_data.each do |row|
  #     if row[:q2] == team && row[:q22] == sprint
  #       return [
  #         row[:q2_1], row[:q2_2], row[:q2_3],
  #         row[:q2_4], row[:q2_5], row[:q2_6]
  #       ]
  #     end
  #   end
  #   nil
  # end
  #
  # def process_client_data_for_responses(semester, team, sprint, flags, not_empty_questions)
  #   client_survey = []
  #   client_question_titles = []
  #
  #   begin
  #     # Downloads and temporarily store the client_csv file
  #     semester.client_csv.open do |temp_client|
  #       client_data = SmarterCSV.process(temp_client.path)
  #       client_survey = client_data.find_all { |client_survey| client_survey[:q2] == team && client_survey[:q22] == sprint }
  #       client_question_titles = client_data[0]
  #
  #       if client_survey.blank?
  #         flags.append("client blank")
  #       end
  #
  #       check_client_questions(client_survey, not_empty_questions)
  #     end
  #   rescue => exception
  #     flash.now[:alert] = "This semester does not have a client survey"
  #     flags.append("client blank")
  #   end
  #
  #   [client_survey, client_question_titles]
  # end
  #
  #
  # def check_client_questions(client_survey, not_empty_questions)
  #   # ... (Move the code related to checking client questions here)
  # end

end