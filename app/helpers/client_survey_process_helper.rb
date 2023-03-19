module ClientSurveyProcessHelper

  # TODO: Refactor the "def team" function located in 'controllers/semesters_controller.rb'. Other refctor part in 'helpers/student_survey_process_helper'

  # def process_client_data
  #   return unless @semester.client_csv.attached?
  #
  #   @semester.client_csv.open do |temp_client|
  #     begin
  #       @client_data = SmarterCSV.process(temp_client.path)
  #       process_client_surveys
  #       check_client_questions
  #     rescue => exception
  #       flash.now[:alert] = "Unable to process file"
  #     end
  #   end
  # rescue => exception
  #   flash.now[:alert] = "This semester does not have a client survey"
  #   @flags.append("client blank")
  # end
  #
  #
  # def process_client_surveys
  #   @cli_survey = @client_data.find_all { |client_survey| client_survey[:q2] == @team && client_survey[:q22] == "#{@sprint}" }
  #   @client_question_titles = @client_data[0]
  #
  #   if @cli_survey.blank?
  #     @flags.append("client blank")
  #   end
  # end
  #
  # def check_client_questions
  #   # Logic for checking client questions
  # end

end