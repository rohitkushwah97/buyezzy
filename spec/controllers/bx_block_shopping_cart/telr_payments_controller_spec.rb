require 'rails_helper'

RSpec.describe BxBlockShoppingCart::TelrPaymentsController, type: :controller do

  before do
    @customer = FactoryBot.create(:account, user_type: 'buyer')
    @customer_2 = FactoryBot.create(:account, user_type: 'buyer')
    @token_buyer = BuilderJsonWebToken.encode(@customer.id, token_type: 'login')
    @token_buyer_2 = BuilderJsonWebToken.encode(@customer.id, token_type: 'login')
    @order_status = BxBlockOrderManagement::OrderStatus.find_by(name: 'On Going') || BxBlockOrderManagement::OrderStatus.create(name: 'On going')
    @order_status_ordered = BxBlockOrderManagement::OrderStatus.find_by(name: 'Ordered') || BxBlockOrderManagement::OrderStatus.create(name: 'Ordered')
    @order = create(:shopping_cart_order, customer: @customer)
    @order_2 = create(:shopping_cart_order, customer: @customer_2)
    @order.update(order_status: @order_status)
    @seller = FactoryBot.create(:account, company_or_store_name: "byezzy", user_type: 'seller')
    @catalogue = create(:catalogue, seller: @seller)
    @product_content = create(:product_content, catalogue: @catalogue)
    @order_item = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order)
    @order_item_2 = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order_2)
  end

  describe 'POST #create' do
    it 'creates a new order status and updates the order with the transaction id' do

      stub_request(:post, "https://secure.telr.com/gateway/order.json")
        .to_return(body: { 'order' => { 'ref' => '123456789' } }.to_json, status: 200)

      # allow(controller).to receive(:post_gateway).and_return(({ 'order': { 'ref': '123456789' } }).to_json)
      
      post :create, params: { order_id: @order.id, final_price: 100, token: @token_buyer }
      
      expect(response).to have_http_status(:ok)
      expect(@order.reload.transaction_id).to eq('123456789')
    end

    it 'renders an error if the order is already processed' do
      @order.update(order_status: @order_status_ordered)

      post :create, params: { order_id: @order.id, final_price: @order.final_price, token: @token_buyer }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to eq('On going orders only accepted')
    end
  end

  describe 'GET #show_or_check' do
    it 'returns the response from the payment gateway' do
      stub_request(:post, "https://secure.telr.com/gateway/order.json")
        .to_return(body: { 'status' => 'success' }.to_json, status: 200)

      # allow(controller).to receive(:post_gateway).and_return({ 'status' => 'success' })

      get :show_or_check, params: { order_id: @order.id, token: @token_buyer }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['status']).to eq('success')
    end
  end

  describe 'Post #payment failed notification' do
    it 'returns the response notification failed' do
      post :payment_failed_notification, params: { order_id: @order.id, token: @token_buyer }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Payment failed notification sent successfully.')
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
