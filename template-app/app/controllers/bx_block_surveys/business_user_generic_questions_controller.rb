module BxBlockSurveys
  class BusinessUserGenericQuestionsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, except: [:business_user_generic_questions]
    before_action :authenticate_account, except: [:business_user_generic_questions]
    before_action :find_business_user, except: [:business_user_generic_questions]

    def index
      questions = BxBlockSurveys::BusinessUserGenericQuestion.all
      if questions.present?
        render json: BxBlockSurveys::BusinessUserGenericQuestionSerializer.new(questions),status: 200
      else
        render json: { data: [] },status: :not_found
      end
    end

    def business_user_generic_questions
      @questions = BxBlockSurveys::BusinessUserGenericQuestion.all
    end

    private

    def find_business_user
      return render json: {error: 'invalid user, account should be business account' } unless @current_user.type == 'BusinessUser'
    end
  end
end