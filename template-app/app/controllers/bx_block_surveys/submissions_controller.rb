module BxBlockSurveys
  class SubmissionsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token,:authenticate_account
    before_action :business? , only: [:questions_and_answer,:create_intern_characteristic_importances]
    before_action :find_user_survey, only: [:create,:create_intern_characteristic_importances]

    def create
      answers = params[:answers]
      role_id = params[:role_id]
      
      unless answers.present? && role_id.present?
        return render json: {errors: "Answers and role_id need to be present"},status: 404
      end
      
      begin
        if @user_survey.retake
          @user_survey.update(quiz_status: "pending",retake: false)
        end

        questions_count = BxBlockSurveys::Survey.find_by(role_id: params[:role_id]).versions.last.questions.count
        @user_survey.submissions.destroy_all

        answers.each do |answer|
          question = BxBlockSurveys::Question.find_by_id(answer[:question_id])
          @version_id = question.version.id
          @user_survey.submissions.create!(question_id:answer[:question_id],option_id:answer[:option_id], version_id: question.version.id,option_value: answer[:option_position],intern_characteristic_id: question.intern_characteristic_id,default_weight: question.default_weight)
        end
        @user_survey.update!(version_id: @version_id,quiz_status: 'completed',retake: false) if @user_survey.submissions.count == questions_count
        intern_message = "Congratulations! You’re all set! Your personalised recommendations are ready. Start applying for internships in your matched roles now."
        business_message = "Congratulations! You are all set! You can Publish your internship now!"

        message = @user_survey.account.type ==  "InternUser" ? intern_message : business_message
        

        render json: { message: message}, status: 200
      rescue StandardError => e
        return render json: {errors: "It looks like some mandatory items are missing."}, status: 422
      end
    end

    def index
      type = @current_user.type
      if type == "InternUser"
        user_survey = get_user_survey({account_id: @current_user.id,role_id:params[:role_id]})
        @submitted_data = submitted_data(user_survey,type)
      else
        user_survey = get_user_survey({account_id: @current_user.id,role_id:params[:role_id],internship_id:params[:internship_id]})
        @submitted_data = submitted_data(user_survey,type)
        intern_characteristic_importances = user_survey&.intern_characteristic_importances
        intern_characteristic_importances_data = BxBlockSurveys::InternCharacteristicImportanceSerializer.new(intern_characteristic_importances).serializable_hash[:data]
        @submitted_data.merge!({intern_characteristic_importances:intern_characteristic_importances_data})
      end
      render json: @submitted_data ,status: 200
    end
    
    def questions_and_answer
      user_survey = get_user_survey({account_id: params[:intern_user_id],role_id:params[:role_id]})
      completed = user_survey.submissions.last.updated_at.strftime('%d/%m/%y') rescue nil
      res = BxBlockSurveys::QuestionsAndAnswersSerializer.new(user_survey&.submissions).serializable_hash
      render json: res.merge!({completed:completed}) ,status: 200
    end
    
    def create_intern_characteristic_importances
      intern_characteristic = params[:intern_characteristic_importances]
      begin
        @user_survey.intern_characteristic_importances.destroy_all
        intern_characteristic.each do |characteristic|
          @user_survey.intern_characteristic_importances.create!(intern_characteristic_id:characteristic[:intern_characteristic_id], value:characteristic[:value])
        end
        render json: { message: "Intern Characteristic Values are submitted."}, status: 200
      rescue StandardError => e
        return render json: {error: e}, status: 422
      end
    end

    private

    def find_user_survey
      @user_survey = @current_user.user_surveys.find_by(role_id: params[:role_id],internship_id: params[:internship_id])
    end

    def get_user_survey(find_fields)
      BxBlockSurveys::UserSurvey.includes(:submissions).find_by(find_fields)
    end

    def submitted_data(user_survey,type)
      BxBlockSurveys::SubmissionSerializer.new(user_survey&.submissions,user_type(type)).serializable_hash
    end

    def user_type(type)
      {params: {type:type}}
    end
  end
end