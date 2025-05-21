module BxBlockSurveys
  class InternUserGenericQuestionsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token,:authenticate_account, except: [:dummy_trigger_exception, :intern_user_generic_questions, :get_applicants]
    before_action :find_business_user,  only: [:create, :update]

    def dummy_trigger_exception
      begin
       raise StandardError, "server is not working"          
      rescue StandardError => e
        render json: {error: e}, status: :internal_server_error
      end
    end

    def index
      questions = BxBlockSurveys::InternUserGenericQuestion.where(internship_id: params[:internship_id])
      if questions.present?
        render json: BxBlockSurveys::InternUserGenericQuestionSerializer.new(questions),status: 200
      else
        render json: { data: [] },status: :not_found
      end
    end

    def create
      ActiveRecord::Base.transaction do
        params[:intern_user_generic_questions].each do |generic_question|
          delete_question(generic_question[:data]) if generic_question[:action_type] == 'delete'
          update_question(generic_question[:data]) if generic_question[:action_type] == 'update'
          create_question(generic_question[:data],generic_question[:internship_id]) if generic_question[:action_type] == 'create'
        end
        return render json: {message: 'Extra questions added successfully.'}, status: 201
      rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end

    def intern_user_generic_questions
      @internship = BxBlockNavmenu::Internship.find(params[:format])
      @questions_with_answers = BusinessUserGenericQuestion
                                   .joins(:business_user_generic_answers)
                                   .where(business_user_generic_answers: { internship_id: @internship.id })
                                   .select('business_user_generic_questions.question AS question,
                                            business_user_generic_answers.answer AS answer')
    end
    def get_applicants
      @internship = BxBlockNavmenu::Internship.find(params[:id])
      @applicants = @internship.accounts
    end

    private

    def create_question(questions,internship_id)
      questions.each do |question|
        BxBlockSurveys::InternUserGenericQuestion.create!(business_user_id: @current_user.id, internship_id: internship_id, question: question[:question])
      end
    end

    def delete_question(questions)
      questions.each do |question|
        BxBlockSurveys::InternUserGenericQuestion.find(question).destroy
      end
    end

    def update_question(questions)
      questions.each do |question|
        internship_question = BxBlockSurveys::InternUserGenericQuestion.find(question[:id])
        internship_question.update!(question: question[:question])
      end
    end

    def find_business_user
      return render json: {error: 'invalid user, account should be business account' } unless @current_user.type == 'BusinessUser'
    end
  end
end