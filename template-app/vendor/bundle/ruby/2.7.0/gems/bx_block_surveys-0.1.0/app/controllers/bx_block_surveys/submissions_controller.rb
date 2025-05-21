module BxBlockSurveys
  class SubmissionsController < ApplicationController
    before_action :find_question, only: [:create]
    before_action :load_submission, only: [:show_submission]

    def index
      submission = BxBlockSurveys::Submission.all.order(created_at: :desc)
      render json: BxBlockSurveys::SubmissionSerializer.new(submission).serializable_hash, status: :ok
    end
    
    def create
      submitted_data = []
      
      params[:data].each do |object|
        question_id = object["question_id"]
        @question = BxBlockSurveys::Question.find_by(id: question_id)
        
        if @question
          submission = BxBlockSurveys::Submission.new(
            account_id: current_user.id,
            question_id: @question.id,
            answer_type: @question.question_type
          )
          
          case @question.question_type
          when 'rating'
            submission.rating = object["answer"]&.to_i
          when 'checkbox', 'radio'
            submission.option_ids = object[:answer].map { |a| a["id"] } if object[:answer].is_a?(Array)
          else
            submission.answer = object["answer"]
          end
          submitted_data << submission if submission.save
        end
      end
      render json: BxBlockSurveys::SubmissionSerializer.new(submitted_data, meta: {message: "Answer succesfully submitted"}).serializable_hash, status: :created
    end    

    def show_submission
      render json: BxBlockSurveys::SubmissionSerializer.new(@submissions).serializable_hash, status: :ok
    end
    
    private

    def find_question
      @questions = BxBlockSurveys::Question.where(id: params[:data].pluck("question_id"))
      render json: {errors: "question_id doesn't exists"} and return unless @questions.present?
    end

    def load_submission
      @submissions = BxBlockSurveys::Submission.where(account_id: current_user.id )
      render json: {errors: "submissions doesn't exists"} and return unless @submissions.present?
    end
  end
end
