require 'rails_helper'

RSpec.describe BxBlockSalesreporting::ProductViewsController, type: :controller do

  let(:catalogue) { create(:catalogue, status: true) }
  let(:user) {create(:account, user_type: "buyer")}
  let(:token) { BuilderJsonWebToken.encode(user.id) }
  let(:invalid_user) { create(:account, user_type: "seller") }
  let(:token2) { BuilderJsonWebToken.encode(invalid_user.id) }
  

  let(:valid_attributes) do
    {
      product_view: {
        catalogue_id: catalogue.id,
        user_id: user.id
      }
    }
  end

  describe 'POST #create' do
    context 'with valid params' do

      it 'renders a JSON response with the new product view' do
        post :create, params: valid_attributes

        expect(response).to have_http_status(:created)  
        expect(response_body['success']).to eq(true)   
      end
    end


    context 'with invalid params' do
      it 'renders a JSON response with errors for the new product view' do
        valid_attributes[:product_view][:catalogue_id] = ""
        post :create, params: valid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['errors']).to include("Catalogue must exist")
      end
    end
  end

  describe 'GET #browsing_history' do
    context 'when user is valid/invalid' do

      it 'returns a success response' do
        product_view = create(:product_view, user: user, catalogue: catalogue, viewed_at: 10.days.ago)
        get :browsing_history, params: {token: token}

        expect(response).to have_http_status(:ok)
        expect(response_body['data'].first['attributes']['viewed_at'].to_json).to eq(product_view.viewed_at.to_json)
      end

      it 'returns a success response with latest view' do
        product_view1 = create(:product_view, user: user, catalogue: catalogue, viewed_at: Time.now)
        get :browsing_history, params: {token: token}

        expect(response_body['data'].first['attributes']['viewed_at'].to_json).to eq(product_view1.viewed_at.to_json)
      end

      it 'returns a error response' do
        get :browsing_history, params: {token: token2}

        expect(response).to have_http_status(:ok)
        expect(response_body['errors']).to eq('Buyer is invalid')
      end


    end
  end

  private

  def response_body
    JSON.parse(response.body)
  end
end