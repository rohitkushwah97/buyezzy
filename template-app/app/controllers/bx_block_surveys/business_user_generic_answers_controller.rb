module BxBlockSurveys
  class BusinessUserGenericAnswersController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, :authenticate_account,:business?

    def index
      generic_answers =  @current_user.business_user_generic_answers.where(internship_id: params[:internship_id])
      res = BusinessUserGenericAnswerSerializer.new(generic_answers)
      render json: res, status:status
    end
    
    def create
      question = BxBlockSurveys::BusinessUserGenericQuestion.find_by(id: business_user_generic_answer_params[:business_user_generic_question_id])
      answer = question.business_user_generic_answers.find_by(business_user_id: @current_user.id)
      unless answer.present?
        generic_answer = @current_user.business_user_generic_answers.new(business_user_generic_answer_params)
        if generic_answer.save
          return render json: { data: generic_answer },status: :created
        else
          return render json: { error: generic_answer.errors.full_messages },status: :unprocessable_entity
        end
      else
        if answer.update(business_user_generic_answer_params)
          return render json: { data: answer },status: :ok
        else
          return render json: { error: answer.errors.full_messages },status: :unprocessable_entity
        end
      end
    end

    private

    def business_user_generic_answer_params
      params.require(:business_user_generic_answer).permit(:answer, :internship_id, :business_user_generic_question_id)
    end
  end
end