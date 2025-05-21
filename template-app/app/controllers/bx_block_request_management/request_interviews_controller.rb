# frozen_string_literal: true

module BxBlockRequestManagement
  class RequestInterviewsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, :authenticate_account
    before_action :set_request_for_interviews, only: [:accept_request_interviews, :reject_request_interviews]
    before_action :authorize_user_for_interview_request, only: [:accept_request_interviews, :reject_request_interviews]

    def create
      request_interview = RequestInterview.new(request_interview_params)
      request_interview.business_user_id = @current_user.id

      if request_interview.save
        account_internship = BxBlockNavmenu::AccountInternship.find_by(
          internship_id: request_interview.internship_id,
          account_id: request_interview.intern_user_id
        )
        if account_internship.present?
          account_internship.update(status: :interview_requested)
        end

        render json: { message: "Interview scheduled successfully", data: request_interview }, status: :created
      else
        render json: { errors: request_interview.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def accept_request_interviews
      if @request_interview && @request_interview.pending?
        @request_interview.update(status: :accepted)
        render json: { message: 'request_interview accepted successfully.' }, status: :ok
      else
        render json: { error: 'request_interview cannot be accepted.' }, status: :unprocessable_entity
      end
    end

    def reject_request_interviews
      if @request_interview && @request_interview.pending?
        @request_interview.update(status: :rejected)
        render json: { message: 'request_interview rejected successfully.' }, status: :ok
      else
        render json: { error: 'request_interview cannot be rejected.' }, status: :unprocessable_entity
      end
    end

    private

    def set_request_for_interviews
      @request_interview = RequestInterview.find_by(id: params[:request_interview_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'interview request not found.' }, status: :not_found
    end

    def authorize_user_for_interview_request
      unless @request_interview&.intern_user_id == @current_user.id
        render json: { error: 'You are not authorized to perform this action.' }, status: :not_found
      end
    end

    def request_interview_params
      params.require(:request_interview).permit(:intern_user_id, :status, :internship_id, :number_of_days, :business_user_id)
    end
  end
end
