module BxBlockSurveys
  class QuestionsController < ApplicationController
    before_action :load_question, only: [:show]

    def index
      if params[:id].present? 
        @survey = BxBlockSurveys::Survey.find_by(id: params[:id]) 
        questions = @survey.questions 
        render json: BxBlockSurveys::QuestionSerializer.new(questions).serializable_hash, status: :ok 
      else 
        questions = BxBlockSurveys::Question.all.order(created_at: :desc) 
        render json: BxBlockSurveys::QuestionSerializer.new(questions).serializable_hash, status: :ok 
      end 
    end

    def show
      render json: BxBlockSurveys::QuestionSerializer.new(@question).serializable_hash, status: :ok
    end
    
    private

    def load_question
      @question = BxBlockSurveys::Question.find_by(id: params[:id])
      render json: {errors: "Id doesn't exists"} and return unless @question.present?
    end
  end
end
