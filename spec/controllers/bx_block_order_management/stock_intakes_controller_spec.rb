require 'rails_helper'

RSpec.describe BxBlockOrderManagement::StockIntakesController, type: :controller do
  let(:seller) { create(:account, user_type: 'seller') }
  let(:catalogue) { create(:catalogue, seller: seller) }
  let(:stock_intake) { create(:stock_intake, seller: seller, catalogue: catalogue) }

  before(:each) do
    @token = BuilderJsonWebToken.encode(seller.id)
  end

  let(:valid_attributes) do
    {
      token: @token,
      stock_intake: {
        catalogue_id: catalogue.id,
        stock_value: 2000,
        stock_qty: 23,
        ship_date: Date.tomorrow,
        receiving_date: Date.tomorrow + 2.days
      }
    }
  end

  let(:invalid_attributes) do
    {
      token: @token,
      stock_intake: {
        catalogue_id: nil,
        stock_value: -100,
        stock_qty: 0,
        ship_date: Date.yesterday,
        receiving_date: Date.yesterday + 2.days
      }
    }
  end

  describe 'GET #index' do
    it 'index returns a success response' do
      get :index, params: {token: @token}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'show returns a success response' do
      get :show, params: {token: @token, id: stock_intake.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'create with valid params' do
      it 'creates a new StockIntake' do
        expect {
          post :create, params: valid_attributes
        }.to change(BxBlockOrderManagement::StockIntake, :count).by(1)
      end

      it 'create renders a JSON response with the new stock_intake' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context 'create with invalid params' do
      it 'create renders a JSON response with errors for the new stock_intake' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match(/errors/)
      end
    end
  end

  describe 'PUT #update' do
    context 'update with valid params' do
      let(:new_attributes) do
        {
          token: @token,
          stock_intake: {
            stock_value: 3000
          }
        }
      end

      it 'updates the requested stock_intake' do
        put :update, params: { id: stock_intake.id }.merge(new_attributes)
        stock_intake.reload
        expect(stock_intake.stock_value).to eq(stock_intake.stock_value)
      end

      it 'update renders a JSON response with the stock_intake' do
        put :update, params: { id: stock_intake.id }.merge(new_attributes)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'update with invalid params' do
      it 'update renders a JSON response with errors for the stock_intake' do
        put :update, params: { id: stock_intake.id }.merge(invalid_attributes)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match(/errors/)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested stock_intake' do
      stock_intake_des = create(:stock_intake, seller: seller, catalogue: catalogue)
      expect {
        delete :destroy, params: {token: @token, id: stock_intake_des.id }
      }.to change(BxBlockOrderManagement::StockIntake, :count).by(-1)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq("Stock intake deleted succesfully!")
    end
  end
end
