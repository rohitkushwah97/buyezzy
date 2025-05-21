module BxBlockChatgpt3
  class ChatbotsController < ApplicationController
    before_action :validate_json_web_token
    before_action :authenticate_account


    before_action :set_intern_user
    before_action :set_prompt_version, only: [:start_interview, :submit_response]
    before_action :validate_interview_request, only: [:start_interview]

    def start_interview
      service = ChatbotService.new(@intern_user, @prompt_version, @request_interview)
      interview = service.start_interview
      question = service.ask_next_question(interview)

      render json: {
        message: "Interview started",
        interview_id: interview.id,
        question: question
      }, status: :ok
    end

    def submit_response
      interview = ChatbotInterview.find_by(id: params[:interview_id], status: 'ongoing')
      return render json: { error: 'No ongoing interview' }, status: :not_found unless interview

      service = ChatbotService.new(@intern_user, interview.prompt_version)

      service.submit_answer(interview, params[:answer])

      if interview.chatbot_responses.where(asked_by: 'system').count >= 5 # replace with dynamic count if needed
        decision = service.evaluate_final_decision(interview)
        return render json: { message: "Interview complete", decision: decision }, status: :ok
      else
        next_question = service.ask_next_question(interview)
        render json: { message: "Answer recorded", next_question: next_question }, status: :ok
      end
    end

    private

    def set_intern_user
      @intern_user = AccountBlock::InternUser.find(params[:intern_user_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Intern user not found" }, status: :not_found
    end

    def set_prompt_version
      @prompt_version = BxBlockChat::PromptVersion.last
    end

    def validate_interview_request
      @request_interview = BxBlockRequestManagement::RequestInterview.find_by(
        intern_user_id: @intern_user.id,
        internship_id: params[:internship_id],
        status: :pending
      )

      unless @request_interview
        render json: { error: "No interview request found or already processed" }, status: :forbidden
      end
    end
  end
end
