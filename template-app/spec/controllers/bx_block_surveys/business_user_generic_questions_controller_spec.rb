require 'rails_helper'

RSpec.describe BxBlockSurveys::BusinessUserGenericQuestionsController, type: :controller do
	business_user =  FactoryBot.create(:business_user)
	token = BuilderJsonWebToken.encode(business_user.id)
	let(:json_response) { JSON.parse(response.body) }

	describe 'GET #index' do
		before do 
			BxBlockSurveys::BusinessUserGenericQuestion.destroy_all
		end
			
		it 'get all BusinessUserGenericQuestions' do
			questions = FactoryBot.create(:business_user_generic_question)
			get :index, params: { token: token }
			expect(response).to have_http_status(:ok)
			expect( json_response['data'][0]['id'].to_i).to eq(questions.id)
		end

		it 'BusinessUserGenericQuestions is not present' do
			get :index, params: { token: token }
			expect(response).to have_http_status(:not_found)
			expect( json_response['data']).to eql([])
		end
	end

	describe 'GET #business_user_generic_questions' do
    context 'when there are business user generic questions' do
      let!(:questions) { create_list(:business_user_generic_question, 3) }

      before do
        get :business_user_generic_questions
      end

      it 'returns a successful response' do
        # expect(response).to have_http_status(:ok)
      end
    end
  end
end