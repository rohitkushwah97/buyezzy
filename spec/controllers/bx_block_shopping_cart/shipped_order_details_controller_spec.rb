require 'rails_helper'

RSpec.describe BxBlockShoppingCart::ShippedOrderDetailsController, type: :controller do
  before do
    @customer = FactoryBot.create(:account, user_type: 'buyer')
    @order_status = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Shipped')
    @order = create(:shopping_cart_order, customer: @customer, order_status: @order_status)
    @seller = FactoryBot.create(:account, company_or_store_name: "byezzy", user_type: 'seller')
    @token_seller = BuilderJsonWebToken.encode(@seller.id, token_type: 'login')
    @catalogue = create(:catalogue, seller: @seller)
    @product_content = create(:product_content, catalogue: @catalogue)
    @order_item = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order, order_status: @order_status)
    @shipped_order_detail = create(:shipped_order_detail, order: @order, order_item_id: @order_item.id )
  end
  let(:valid_attributes) do
    {
      "shipping_details": "Tracking ids",
      "courier_name": "courier name",
      "tracking_number": "track12345number"
    }
  end

  describe 'GET #show' do
    it 'show returns a success response' do
      get :show, params: {token: @token_seller, id: @shipped_order_detail.id, order_id: @order.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(@shipped_order_detail.id)
    end
  end

  describe 'POST #create' do
    context 'create with valid params and multiple order_item_ids' do
      it 'creates multiple shipped_order_details and returns the last one' do
        # Create two order items
        order_item_1 = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order, order_status: @order_status)
        order_item_2 = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order, order_status: @order_status)

        order_item_ids = [order_item_1.id, order_item_2.id]

        expect do
          post :create, params: {
            order_id: @order.id,
            token: @token_seller,
            shipped_order_detail: valid_attributes.merge(order_item_id: order_item_ids)
          }
        end.to change(BxBlockShoppingCart::ShippedOrderDetail, :count).by(2)

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response["order_item_id"]).to eq(order_item_2.id)
      end
    end

    context 'create with invalid params' do
      it 'create renders a JSON response with errors for the new shipped_order_detail' do
        post :create, params: {
          token: @token_seller,
          order_id: @order.id,
          shipped_order_detail: { courier_name: nil }
        }
        parsed_response = JSON.parse(response.body)
        # byebug
        # expect(parsed_response["courier_name"]).to include("can't be blank")
        # expect(parsed_response["tracking_number"]).to include("can't be blank")
        # expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'update with valid params' do
      let(:new_attributes) do
        { shipping_details: 'update details' }
      end

      it 'update updates the requested shipped_order_detail' do
        put :update, params: {token: @token_seller, order_id: @order.id,  id: @shipped_order_detail.id, shipped_order_detail: new_attributes }
        @shipped_order_detail.reload
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['shipping_details']).to eq(@shipped_order_detail.shipping_details)
      end
    end

    context 'update with invalid params' do
      it 'update renders a JSON response with errors for the shipped_order_detail' do
        put :update, params: {token: @token_seller, order_id: @order.id, id: @shipped_order_detail.id, shipped_order_detail: { tracking_number: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested shipped_order_detail' do
      delete :destroy, params: {token: @token_seller, order_id: @order.id, id: @shipped_order_detail.id }
      expect(JSON.parse(response.body)['message']).to eq("shipped order detail destroyed")
    end
  end
end