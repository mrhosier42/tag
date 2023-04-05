class SemestersController < ApplicationController
    include ProcessClientSurveyHelper
    include ProcessStudentSurveyHelper
    require 'text'
    helper_method :get_client_score
    helper_method :team_exist
    helper_method :get_flags
    helper_method :unfinished_sprint

    def home
        @semesters = Semester.order(year: :desc)
        render :home
    end

    def show
        session[:return_to] ||= request.referer
        @semester = Semester.find(params[:id])
        @teams = get_teams(@semester)
        # TODO: allow user to select how many Sprints there are
        @sprint_list = ["Sprint 1", "Sprint 2", "Sprint 3", "Sprint 4"]
        @flags = {}
        @sprint_list.each do |sprint|
            @flags[sprint] = {}
            @teams.each do |team|
                @flags[sprint][team] = get_flags(@semester, sprint, team)
            end
        end
        @repos = current_user.repositories
        @sprints = @semester.sprints
        render :show
    end

    def new
        @semester = Semester.new
        @semester.sprints.build
        # render :new
    end

    def create
        @semester = Semester.new(semester_params)

        if params[:student_csv].present?
            @semester.student_csv.attach(params[:student_csv])
        end

        if params[:client_csv].present?
            @semester.client_csv.attach(params[:client_csv])
        end

        if @semester.save
            redirect_to @semester, notice: 'Semester was successfully created.'
        else
            render :new
        end
    end


    def edit
        session[:return_to] ||= request.referer
        @semester = Semester.find(params[:id])
        render :edit
    end

    def update
        @semester = Semester.find(params[:id])
        if @semester.update(params.require(:semester).permit(:semester, :year, :student_csv, :client_csv))
            flash[:success] = "Semester was successfully updated!"
            redirect_to semester_url(@semester)
        else
            flash.now[:error] = "Semester update failed!"
            render :edit
        end
    end

    def destroy
        @semester = Semester.find(params[:id])
        @semester.destroy
        redirect_to semester_path, notice: 'Semester was successfully deleted.'
    end

    # --------------------------------------------------------------------------

    def get_teams(semester)
        @teams = []

        begin
            semester.student_csv.open do |tempfile|
                begin
                    @student_data = SmarterCSV.process(tempfile.path)
                    @student_data.slice!(0, 2) # Remove the 2 header columns before the data
                    @teams = get_unique_teams(@student_data)
                    puts "DEBUG: team action: #{@teams.inspect}"

                rescue => exception
                    flash.now[:alert] = "Error! Unable to read data. Please update your student data file"
                end
            end
        rescue => exception
            flash.now[:alert] = "This semester does not have a student survey"
        end

        session[:teams_list] = @teams
        @teams
    end

    def get_client_score(semester, team, sprint)
        client_score = -1

        semester.client_csv.open do |tempfile|
            begin
                @sponsor_data = SmarterCSV.process(tempfile.path)
                @sponsor_data.slice!(0, 2) # Remove the 2 header columns before the data
                client_score_data = process_client_data_for_scores(@sponsor_data, team, sprint)
                client_score = calculate_score(client_score_data) if client_score_data
            rescue => exception
                flash.now[:alert] = "Error! Unable to read sponsor data. Please update your student data file"
            end
        end

        client_score < 0 ? "No Score" : client_score
    end

    def calculate_score(arr)
        score_mapping = {
          "Exceeded expectations" => 5.0,
          "Met expectations" => 4.0,
          "About half the time" => 3.0,
          "Sometimes" => 2.0,
          "Never" => 1.0
        }

        total = arr.sum { |item| score_mapping[item] || 0 } / 6.0
        total.round(1)
    end

    def team_exist(arr)
        arr.length > 0
    end

    def unfinished_sprint(teams, flags, sprint)
        teams.none? { |t| flags[sprint][t] != ["student blank"] }
    end

    private

    def semester_params
        params.permit(
          :semester, :year, sprints_attributes: [
          :id, :_destroy, :start_date, :end_date
        ],
          student_csv: [], client_csv: []
        )
    end


    def team
        @semester = Semester.find(params[:semester_id])
        @teams = get_teams(@semester)
        @teams ||= []
        Rails.logger.debug("team action: #{@teams.inspect}")

        @team = params[:team]
        # TODO: Allow user to select how many Sprint's there are
        @sprints = ["Sprint 1", "Sprint 2", "Sprint 3", "Sprint 4"]
        @sprint = params[:sprint]
        @not_empty_questions = []

        # Stores all the flags for the team
        @flags = []

        # Process student and client data
        @student_survey, @question_titles, @self_submitted_names = process_student_data_for_responses(@semester, @team, @sprint, @flags, @not_empty_questions)
        @client_survey, @client_question_titles = process_client_data_for_responses(@semester, @team, @sprint, @flags, @not_empty_questions)

        render :team
    end


    def get_flags(semester, sprint, team)
        flags = []

        begin
            semester.student_csv.open do |tempStudent|
                begin
                    student_data = SmarterCSV.process(tempStudent.path)
                    student_survey = get_student_survey_data(team, sprint, student_data)

                    if student_survey.blank?
                        flags.append("student blank")
                    end

                    self_submitted_names = get_self_submitted_names(student_survey)
                    update_self_submitted_names(self_submitted_names, student_survey)

                    self_submitted_names.each do |name|
                        update_flags(name, flags)
                    end

                    cscore = get_client_score(semester, team, sprint)
                    flags.append("no client score") if cscore == "No Score"
                    flags.append("low client score") if cscore <= 3
                rescue => exception
                    # Ignored
                end
            end
        rescue => exception
            # Ignored
        end

        flags
    end


end
