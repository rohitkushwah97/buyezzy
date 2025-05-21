module BxBlockSurveys
  class InternUserGenericAnswersController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token,:authenticate_account,:intern?
    before_action :intern? , only: [:create]
    before_action :business?, only: [:generic_answers_and_questions]

    def create
      answers = params[:intern_user_generic_answers]
      internship = BxBlockNavmenu::Internship.find_by_id(params[:internship_id])
      begin
        answers.each do |answer|
          user_answer = @current_user.intern_user_generic_answers.find_by(intern_user_generic_question_id: answer[:intern_user_generic_question_id])
          if user_answer.nil?
            @current_user.intern_user_generic_answers.create!(internship_id: params[:internship_id], intern_user_generic_question_id:answer[:intern_user_generic_question_id],answer: answer[:answer])
          else
            user_answer.update!(answer: answer[:answer])
          end
        end
        @current_user.internships << internship
        render json: { message: 'Internship applied successfully.' }, status: :ok
        create_new_applicant_notification(internship)

      rescue StandardError => e
       render json: { error: e },status: 422
      end
    end

    def generic_answers_and_questions
      answers_and_questions = InternUserGenericAnswer.includes(:intern_user_generic_question).where(account_id: params[:intern_user_id],internship_id: params[:internship_id])
      if answers_and_questions.present?
        completed = answers_and_questions.last.updated_at.strftime('%d/%m/%y')
        res = InternUserGenericAnswerSerializer.new(answers_and_questions).serializable_hash
        render json: res.merge!({completed: completed}) ,status: :ok
      else
        render json: {data: []} ,status: :not_found
      end
    end

    private

    def create_new_applicant_notification(internship)
      heading = "New Application"
      content = "A new application has been received for [#{internship.title}]. Review it in your dashboard."
      navigates_to = "Applicant"
      business_user = internship.business_user
      if business_user&.notification_setting&.turn_off_new_application_alerts
        notification_creator = BxBlockNotifications::NotificationCreator.new(business_user, heading, content, navigates_to)
        notification_creator.call
      end
    end

  end
end