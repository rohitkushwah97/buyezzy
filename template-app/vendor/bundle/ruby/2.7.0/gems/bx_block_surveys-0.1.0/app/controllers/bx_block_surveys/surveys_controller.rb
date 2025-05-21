module BxBlockSurveys
  class SurveysController < ApplicationController
    before_action :load_survey, only: [:show, :update, :destroy]

    def index
      surveys = BxBlockSurveys::Survey.all.order(created_at: :desc)
      render json: BxBlockSurveys::SurveySerializer.new(surveys).serializable_hash, status: :ok
    end

    def show
      render json: BxBlockSurveys::SurveyQuestionSerializer.new(@survey).serializable_hash, status: :ok
    end

    private

    def load_survey
      @survey = BxBlockSurveys::Survey.find_by(id: params[:id])
      
      if @survey.nil?
        render json: { 
            message: "id doesn't exists"
        }, status: :not_found
      end
    end
  end
end
