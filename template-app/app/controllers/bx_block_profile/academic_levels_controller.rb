module BxBlockProfile
  class AcademicLevelsController < ApplicationController
    skip_before_action :validate_json_web_token, :authenticate_account
    
    def index
      res = AcademicLevelSerializer.new(AcademicLevel.all).serializable_hash
      render json: res, status: status
    end

  end
end