module BxBlockTermsandconditions
  class TermsPoliciesController < ApplicationController
    before_action :set_terms_policy, only: [:show]

    def index
      @terms_policies = TermsPolicy.all

      render json: @terms_policies
    end

    def show
      render json: @terms_policy
    end

    private

    def set_terms_policy
      @terms_policy = TermsPolicy.find(params[:id])
    end

  end
end
