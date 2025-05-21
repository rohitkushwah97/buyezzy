ActiveAdmin.register BxBlockSurveys::Version, as: 'Versions' do
	permit_params :id, :name, questions_attributes: [:id, :question_type, :question_title, :rating, :_destroy, :intern_characteristic_id, :default_weight, :business_question, :intern_question, :version_id, options_attributes: [:id, :name]]

    menu false

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.hidden_field :id, value: params[:id]
    f.hidden_field :survey_id, value: params[:version_id] if params[:survey_id].present?

    f.has_many :questions, allow_destroy: true, new_record: true do |a|
      a.input :intern_characteristic_id, as: :select, collection: BxBlockSurveys::InternCharacteristic.all.collect { |intern| [intern.name, intern.id]}, include_blank: false
      a.input :default_weight
      a.input :business_question
      a.input :intern_question

      5.times do |i|
        a.object.options.build if a.object.options[i].nil?
      end

      a.has_many :options, allow_destroy: false, new_record: false do |o|
        option_index = o.index + 1
        o.input :name, label: "Option #{option_index}", input_html: { value: o.object.name }
      end
    end

    f.actions
  end

  controller do
  	before_action :check_validation, only: :update
    before_action :check_question_count, only: :update
    after_action :create_recommecdations, only: :update

    def create_versions
      current_questions = @current_version.questions
      current_questions_map = current_questions.index_by(&:id)

      questions_params = params[:version][:questions_attributes].to_unsafe_h
      new_version_needed = false

      questions_params.each_value do |question_param|
        question = current_questions_map[question_param["id"].to_i]

        unless question_param["id"].present? && question.business_question == question_param["business_question"] && question.intern_question == question_param["intern_question"] && question_param[:_destroy] != "1"
          new_version_needed = true
          break
        end
      end

      if new_version_needed
        new_version = @survey.versions.create
        role = get_role_for_version(new_version)

        notify_users_for_role(role, new_version)

        return [new_version, 'new']
      else
        return [@current_version, 'prev']
      end
    end


    def update
      return unless params[:id].present?
      @survey = BxBlockSurveys::Version.find(params[:id]).survey
      @current_version = BxBlockSurveys::Version.find(params[:id])
      @version = create_versions
      version_params = permitted_params[:version]

      if version_params[:questions_attributes].present?
        version_params[:questions_attributes].each do |_, question_params|
          next if question_params[:_destroy] == "1"

          if @version[1] == "new"
            clean_options_for_new(question_params)

            @version[0].questions.create(
              survey_id: @survey.id,
              intern_characteristic_id: question_params[:intern_characteristic_id],
              default_weight: question_params[:default_weight],
              business_question: question_params[:business_question],
              intern_question: question_params[:intern_question],
              options_attributes: question_params[:options_attributes]
            )
          else
            update_existing_question(question_params)
          end
        end
      end

      redirect_to version_list_admin_question_surveys_path(survey_id: @survey.id)
    end

    def get_role_for_version(version)
      survey = version.survey
      survey.role
    end

    def notify_users_for_role(role, version)
      heading = "New Version Created for #{role.name}"
      navigates_to = "Answer Quizzes to Access the roles"
      content = "A new version (#{version.name}) has been created for the role #{role.name}. Please review and complete the pending quizzes."
      career_interests = BxBlockSurveys::UserSurvey.where(role_id: role.id)
      career_interests.each do |career_interest|
        intern_user = career_interest.account
        notification_creator = BxBlockNotifications::NotificationCreator.new(intern_user, heading, content, navigates_to)
        notification_creator.call
      end
    end

    def create_recommecdations
      BxBlockRecommendation::CreateRecommendationsJob.perform_later(@current_version.id,@survey.role_id) if @version[0] == @current_version
    end

    def check_question_count
      questions_count = params['version']['questions_attributes'].to_unsafe_h.values.count

      if questions_count > 20
        flash[:alert] = "Cannot exceed 20 questions per role."
        redirect_to edit_admin_version_path(id: params[:id], survey_id: params[:survey_id]) and return
      end
    end

    def check_validation
      questions_params = params[:version][:questions_attributes].to_unsafe_h
      version = BxBlockSurveys::Version.find(params[:version][:id])

      if questions_params.values.all? { |question_param| question_param[:_destroy] == "1" }
        flash[:alert] = "At least one question must be present. You cannot remove all questions."
        redirect_to edit_admin_version_path(id: version.id, survey_id: version.survey.id) and return
      end

      total_default_weight = 0  # Initialize total weight variable

      questions_params.each_value do |question_param|
        unless validate_question_fields(question_param, version)
          return
        end

        unless validate_options(question_param[:options_attributes], version)
          return
        end
        total_default_weight += question_param[:default_weight].to_i unless question_param[:_destroy] == "1"
      end
      if total_default_weight != 100
        flash[:alert] = "The total default weight for all questions must sum to exactly 100."
        redirect_to edit_admin_version_path(id: version.id, survey_id: version.survey.id) and return
      end
    end

    private

    def validate_question_fields(question_param, version)
      if question_param[:business_question].present? && question_param[:intern_question].present? && question_param[:default_weight].present?
        unless (0..100).include?(question_param[:default_weight].to_i)
          flash[:alert] = "Default weight must be between 0 and 100."
          redirect_to edit_admin_version_path(id: version.id, survey_id: version.survey.id)
          return false
        end
        true
      else
        flash[:alert] = "Business question, intern question, and default weight must be present."
        redirect_to edit_admin_version_path(id: version.id, survey_id: version.survey.id)
        false
      end
    end

    def validate_options(options, version)
      if options.count == 5
        options.each_with_index do |(_, option), index|  # Unpack key-value pair
          unless option[:name].present?
            flash[:alert] = "Option #{index + 1} name can't be blank."
            redirect_to edit_admin_version_path(id: version.id, survey_id: version.survey.id)
            return false
          end
        end
        true
      else
        flash[:alert] = "Exactly 5 options must be present."
        redirect_to edit_admin_version_path(id: version.id, survey_id: version.survey.id)
        false
      end
    end

    # update method's sub methods

    def clean_options_for_new(question_params)
      if question_params[:options_attributes].present?
        question_params[:options_attributes].each { |_, option| option.delete(:id) }
      end
    end

    def update_existing_question(question_params)
      question_params[:version_id] = @version[0].id
      @version[0].update(permitted_params[:version])
    end
  end
end
