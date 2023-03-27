module ProcessStudentSurveyHelper

  def process_student_data(semester, team, sprint, flags, not_empty_questions)
    student_survey = []
    question_titles = []
    self_submitted_names = []

    begin
      # Downloads and temporarily store the student_csv file
      semester.student_csv.open do |tempStudent|
        student_data = SmarterCSV.process(tempStudent.path)

        student_survey = student_data.find_all { |survey| survey[:q2] == team && survey[:q22] == sprint }
        question_titles = student_data[0]

        if student_survey.blank?
          flags.append("student blank")
        end

        self_submitted_names = process_self_submitted_names(student_survey, flags)
        check_student_questions(student_survey, not_empty_questions)
      end
    rescue => exception
      flash.now[:alert] = "This semester does not have any student survey"
      flags.append("student blank")
    end

    [student_survey, question_titles, self_submitted_names]
  end


  def process_self_submitted_names(student_survey, flags)
    # ... (Move the code related to self_submitted_names processing here)
  end


  def check_student_questions(student_survey, not_empty_questions)
    # ... (Move the code related to checking student questions here)
  end

end