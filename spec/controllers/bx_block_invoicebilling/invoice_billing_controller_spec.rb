require 'rails_helper'

RSpec.describe BxBlockInvoicebilling::InvoiceBillingsController, type: :controller do

  before do
    @customer = FactoryBot.create(:account, user_type: 'buyer')
    @customer_2 = FactoryBot.create(:account, user_type: 'buyer')
    @token_buyer = BuilderJsonWebToken.encode(@customer.id, token_type: 'login')
    @token_buyer_2 = BuilderJsonWebToken.encode(@customer_2.id, token_type: 'login')
    @seller = FactoryBot.create(:account, company_or_store_name: "byezzy", user_type: 'seller')
    @catalogue = create(:catalogue, seller: @seller)
    @product_content = create(:product_content, catalogue: @catalogue)
    @order_status_delivered = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Delivered')
    @order = create(:shopping_cart_order, customer: @customer)
    @order_item = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order)
    @order.update(order_status: @order_status_delivered)
    stub_request(:post, "https://secure.telr.com/gateway/order.json")
        .to_return(body: { 'order' => { 'ref' => '123456789' } }.to_json, status: 200)
    @order.update(transaction_id: "123456789")
    @order_2 = create(:shopping_cart_order, customer: @customer_2)
    @order_item_2 = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order_2)
  end

  describe 'GET #invoice_pdf' do
    it 'returns a PDF file with the correct content' do

      get :invoice_pdf, params: { order_id: @order.id, order_item_id: @order_item.id, token: @token_buyer }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['attributes']['order_id']).to eq(@order.id)
      expect(JSON.parse(response.body)['data']['attributes']['invoice_pdf']).to match(/\/rails\/active_storage\/blobs\/.+\/invoice-.+\.pdf/)
    end

    it 'renders an error if the order is not found or not delivered' do

      get :invoice_pdf, params: { order_id: @order_2.id, order_item_id: @order_item_2.id, token: @token_buyer_2 }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq("Order not found or not delivered")
    end

    it 'renders an error if the user is invalid' do

      get :invoice_pdf, params: { order_id: @order.id, order_item_id: @order_item.id, token: @token_buyer_2 }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq("User Invalid")
    end
  end
end

