module BxBlockSurveys
  class QuestionsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token,:authenticate_account

    def index
      @survey = BxBlockSurveys::Survey.find_by(role_id: params[:role_id])
      if @survey&.versions&.present?
        version = @survey.versions.last
        questions = version.questions.includes(:options)
        if @current_user.type == "InternUser"
          render json: {questions:BxBlockSurveys::InternUsersQuestionSerializer.new(questions).serializable_hash, version_id:version.id,role_id:params[:role_id]}, status: :ok
        else
          render json: {questions:BxBlockSurveys::BusinessUsersQuestionSerializer.new(questions).serializable_hash, version_id:version.id,role_id:params[:role_id],intern_characteristic: BxBlockSurveys::InternCharacteristicSerializer.new(BxBlockSurveys::InternCharacteristic.all)}, status: :ok
        end
      else 
        render json: {data:[]},status: 404
      end
    end
  end
end