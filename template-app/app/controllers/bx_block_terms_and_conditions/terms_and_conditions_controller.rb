module BxBlockTermsAndConditions
  class TermsAndConditionsController < ApplicationController
    before_action :validate_json_web_token, :authenticate_account, only: %i(get_privacy_policies)

    def index
      terms = params[:type] == 'intern' ? TermsAndCondition.Intern : TermsAndCondition.Business
      if terms.blank?
        render json: {message: 'Records are not available.'}, status: :not_found
      else
        render json: {data: terms.as_json}, status: :ok
      end
    end

    def get_privacy_policies
      policies = @current_user.type == 'InternUser' ? PrivacyPolicy.Intern : PrivacyPolicy.Business
      if policies.blank?
        render json: { message: "Policy not found." }, status: :not_found
      else
        render json: {data: policies.as_json}, status: :ok
      end
    end 
  end
end