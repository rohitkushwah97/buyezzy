module BxBlockHelpCentre
  class IssueTypesController < ApplicationController
    skip_before_action :validate_json_web_token, only: [:index]
    skip_before_action :authenticate_account, only: [:index]
    def index
      issue_types = BxBlockHelpCentre::IssueType.all
      render json: issue_types, status: :ok
    end
  end
end
