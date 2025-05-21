require 'rails_helper'

RSpec.describe BxBlockShoppingCart::ReturnReasonDetailsController, type: :controller do
  before do
    @customer = FactoryBot.create(:account, user_type: 'buyer')
    @order_status = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Return')
    @order = create(:shopping_cart_order, customer: @customer, order_status: @order_status)
    @seller = FactoryBot.create(:account, company_or_store_name: "byezzy", user_type: 'seller')
    @token_seller = BuilderJsonWebToken.encode(@seller.id, token_type: 'login')
    @catalogue = create(:catalogue, seller: @seller)
    @product_content = create(:product_content, catalogue: @catalogue)
    @order_item = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order, order_status: @order_status)
    @return_reason_detail = create(:return_reason_detail, order_item: @order_item )
  end
  let(:valid_attributes) do
    {
      title: 'Return Reason Title',
      details: 'Return Reason Details',
      shopping_cart_order_item_id: @order_item.id,
      reason_type: 'return_reason'
    }
  end

  describe 'GET #index' do
    it 'index returns a success response' do
      return_reason_detail_1 = create(:return_reason_detail, order_item: @order_item)
      get :index, params: {token: @token_seller}
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)[0]['id']).to eq(return_reason_detail_1.id)
    end
  end

  describe 'GET #show' do
    it 'show returns a success response' do
      get :index, params: {token: @token_seller, id: @return_reason_detail.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)[0]['id']).to eq(@return_reason_detail.id)
    end
  end

  describe 'POST #create' do
    context 'create with valid params' do
      it 'creates a new ReturnReasonDetail' do
        expect do
          post :create, params: { return_reason_detail: valid_attributes, token: @token_seller }
        end.to change(BxBlockShoppingCart::ReturnReasonDetail, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'create with invalid params' do
      it 'create renders a JSON response with errors for the new return_reason_detail' do
        post :create, params: {token: @token_seller, return_reason_detail: { title: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'update with valid params' do
      let(:new_attributes) do
        { title: 'New Title' }
      end

      it 'update updates the requested return_reason_detail' do
        put :update, params: {token: @token_seller, id: @return_reason_detail.id, return_reason_detail: new_attributes }
        @return_reason_detail.reload
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['title']).to eq(@return_reason_detail.title)
      end
    end

    context 'update with invalid params' do
      it 'update renders a JSON response with errors for the return_reason_detail' do
        put :update, params: {token: @token_seller, id: @return_reason_detail.id, return_reason_detail: { title: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested return_reason_detail' do
      expect do
        delete :destroy, params: {token: @token_seller, id: @return_reason_detail.to_param }
      end.to change(BxBlockShoppingCart::ReturnReasonDetail, :count).by(-1)
      expect(JSON.parse(response.body)['message']).to eq('return reason destroy')
    end
  end
end
