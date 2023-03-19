module StudentSurveyPrcessHelper

  # TODO: Refactor the "def team" function located in 'controllers/semesters_controller.rb'. Other refctor part in 'helpers/client_survey_process_helper'

  # def team
  #   @semester = Semester.find(params[:semester_id])
  #   @teams = getTeams(@semester)
  #   @team = params[:team]
  #   @sprints = ["Sprint 1", "Sprint 2", "Sprint 3", "Sprint 4"]
  #   @sprint = params[:sprint]
  #   @not_empty_questions = []
  #   @flags = []
  #
  #   process_student_data
  #   process_client_data
  #
  #   render :team
  # end
  #
  # private
  #
  # def process_student_data
  #   return unless @semester.student_csv.attached?
  #
  #   @semester.student_csv.open do |temp_student|
  #     begin
  #       @student_data = SmarterCSV.process(temp_student.path)
  #       process_student_surveys
  #       check_student_questions
  #     rescue => exception
  #       flash.now[:alert] = "Unable to process file"
  #     end
  #   end
  # rescue => exception
  #   flash.now[:alert] = "This semester does not have any student survey"
  #   @flags.append("student blank")
  # end
  #
  # def process_student_surveys
  #   @stud_survey = @student_data.find_all { |survey| survey[:q2] == @team && survey[:q22] == @sprint }
  #   @question_titles = @student_data[0]
  #
  #   if @stud_survey.blank?
  #     @flags.append("student blank")
  #   end
  #
  #   # Rest of the student survey processing logic
  # end
  #
  # def check_student_questions
  #   @stud_survey.each do |s|
  #     # Rest of the logic for checking student questions
  #   end
  # end


end