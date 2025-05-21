module BxBlockTermsandconditions
  class PrivacyAndLegalPolicyController < ApplicationController
    before_action :set_privacy_and_policy, only: [:show]

    def index
      privacy_policy = PrivacyAndLegalPolicy.all.where(status: true)
      render json: PrivacyAndLegalPolicySerializer.new(privacy_policy).serializable_hash
    end

    def show
      render json: PrivacyAndLegalPolicySerializer.new(@privacy_policy).serializable_hash
    end

    private

    def set_privacy_and_policy
      @privacy_policy = PrivacyAndLegalPolicy.find(params[:id])
    end

  end
end
