require 'rails_helper'

RSpec.describe BxBlockCatalogue::HelpfulReviewsController, type: :controller do
  let(:account) { create(:account, user_type: 'buyer') }
  let(:account2) { create(:account, user_type: 'buyer') }
  let(:token) { BuilderJsonWebToken.encode(account2.id, token_type: 'login') }
  let(:token1) { BuilderJsonWebToken.encode(0, token_type: 'login') }
  let(:review) { create(:review) }
  let(:helpful_review) { create(:helpful_review, review: review, customer: account2) }

  describe 'POST #create' do
    context 'when marking a review as helpful' do
      it 'creates a new HelpfulReview record' do
        post :create, params: { review_id: review.id, token: token }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Marked as helpful')
      end

      it 'returns an error when the HelpfulReview cannot be saved' do
        post :create, params: { review_id: review.id, token: token  }
        post :create, params: { review_id: review.id, token: token }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Could not mark as helpful')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when unmarking a review as helpful' do
      before do
        helpful_review 
      end

      it 'removes the HelpfulReview record' do

        delete :destroy, params: { review_id: review.id, token: token }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Unmarked as helpful')
      end

      it 'returns an error if there is no HelpfulReview record to destroy' do
        delete :destroy, params: { review_id: review.id, token: token }
        delete :destroy, params: { review_id: review.id, token: token }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Could not unmark as helpful')
      end

      it 'returns an error if account not found' do
        delete :destroy, params: { review_id: review.id, token: token1 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq("Account does not exist")
      end
    end
  end
end
