module AccountBlock
  class SuggestionFeedbacksController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token
    # before_action :current_user
    before_action :set_suggestion_feedback, only: [:show, :destroy]

    def index
      @suggestion_feedbacks = SuggestionFeedback.all.where(account_id: @token&.id)
        render json: SuggestionFeedbackSerializer.new(@suggestion_feedbacks, meta: {
         message: "Successfully Loaded"
       }).serializable_hash, status: :ok
    end

    def show
      if @suggestion_feedback.present?
        render json: SuggestionFeedbackSerializer.new(@suggestion_feedback, meta: {
         message: "Successfully Loaded"
       }).serializable_hash, status: :ok
      end
    end

    def create
      suggestion_feedback_params = jsonapi_deserialize(params)
      validator = EmailValidation.new(suggestion_feedback_params["email"])
      if !validator.valid?
        return render json: {errors: [
          {account: "Email invalid"}
        ]}, status: :unprocessable_entity
      end
      @suggestion_feedback = SuggestionFeedback.new(suggestion_feedback_params.merge(account_id: @token&.id))

      if @suggestion_feedback.save
        render json: SuggestionFeedbackSerializer.new(@suggestion_feedback).serializable_hash, status: :created
      else
        render json: @suggestion_feedback.errors, status: :unprocessable_entity
      end
    end

  # def update
  #   if @suggestion_feedback.update(suggestion_feedback_params)
  #     render json: @suggestion_feedback
  #   else
  #     render json: @suggestion_feedback.errors, status: :unprocessable_entity
  #   end
  # end

    def destroy
      if @suggestion_feedback&.destroy
        render json:{ meta: { message: "Suggestion or Feedback Removed"}}
      end
    end

    private

    # def current_user
    #   @current_user = Account.find_by(id: @token.id)
    # end

    def set_suggestion_feedback
      @suggestion_feedback = SuggestionFeedback.find(params[:id])
    end
  end
end