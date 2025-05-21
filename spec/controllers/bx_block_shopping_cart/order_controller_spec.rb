require 'rails_helper'

RSpec.describe BxBlockShoppingCart::OrdersController, type: :controller do
  include ActiveJob::TestHelper
  before do
    @customer = FactoryBot.create(:account, user_type: 'buyer')
    @token_buyer = BuilderJsonWebToken.encode(@customer.id, token_type: 'login')
    @order_status = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'On going')
    @order_status_completed = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Completed')
    @order_status_shipped = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Shipped')
    @order_status_ordered = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Ordered')
    @order_status_delivered = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Delivered')
    @order_status_return = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Return')
    @order = create(:shopping_cart_order, order_placed_at: Time.current, customer: @customer, order_status: @order_status)
    @seller = FactoryBot.create(:account, company_or_store_name: "byezzy", user_type: 'seller')
    @token_seller = BuilderJsonWebToken.encode(@seller.id, token_type: 'login')
    @catalogue = create(:catalogue, seller: @seller)
    @product_content = create(:product_content, catalogue: @catalogue)
    @order_item = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order, accepted: false )
    @order_1 = create(:shopping_cart_order,  order_placed_at: 5.days.ago, customer: @customer, order_status: @order_status)
    @order_item_1 = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order_1)
    @coupon = create(:coupon)
  end

describe 'GET #show' do
  it 'returns the order detail' do
    get :show, params: { id: @order.id, token: @token_buyer }

    expect(response).to have_http_status(:ok)
    expect(response_body['data']['id']).to eq(@order.id.to_s)
    expect(response_body['data']['attributes']['order_items']['data'][0]['id']).to eq(@order_item.id.to_s)
  end

  it 'returns the order details and updates order items if status if on_going or scheduled' do
    allow_any_instance_of(BxBlockShoppingCart::OrderItem).to receive(:assign_price_to_order_item).and_call_original
    allow_any_instance_of(BxBlockShoppingCart::OrderItem).to receive(:save).and_call_original

    get :show, params: { id: @order.id, token: @token_buyer }
    expect(response).to have_http_status(:ok)
    expect(response_body['data']['attributes']['final_price']).to eq(@order.final_price)
    expect(response_body['data']['attributes']['order_items']['data'][0]['attributes']['price']).to eq(@order_item.price)

  end

  it 'returns the order details and updates order items if catalogue has offers' do
    offer_order = create(:shopping_cart_order, customer: @customer, order_status: @order_status)
    offer_catalogue = create(:catalogue, seller: @seller)
    offer_catalogue_prod_cont = create(:product_content, catalogue: offer_catalogue)
    offer = create(:catalogue_offer, catalogue: offer_catalogue, status: true)
    offer_order_item = create(:shopping_cart_order_item, catalogue: offer_catalogue, order: offer_order)

    get :show, params: { id: offer_order.id, token: @token_buyer }
    expect(response_body['data']['attributes']['order_items']['data'][0]['attributes']['price']).to eq(offer.sale_price)
    expect(response_body['data']['attributes']['discount']).to eq(offer_order.discount)

  end

  it 'returns the order details and updates order items if catalogue as deal' do
    deal_order = create(:shopping_cart_order, customer: @customer, order_status: @order_status)
    deal_catalogue = create(:catalogue, seller: @seller)
    deal = create(:deal)
    seller_catalogue = create(:deal_catalogue, deal: deal, catalogue: deal_catalogue, seller: @seller, status: 1 )
    offer_order_item = create(:shopping_cart_order_item, catalogue: deal_catalogue, order: deal_order)
    allow_any_instance_of(BxBlockShoppingCart::OrderItem).to receive(:assign_price_to_order_item).and_call_original
    allow_any_instance_of(BxBlockShoppingCart::OrderItem).to receive(:assign_discount_to_order).and_call_original
    allow_any_instance_of(BxBlockShoppingCart::OrderItem).to receive(:calculate_final_price).and_call_original
    allow_any_instance_of(BxBlockShoppingCart::OrderItem).to receive(:calculate_final_discount_price).and_call_original
    allow_any_instance_of(BxBlockShoppingCart::OrderItem).to receive(:save).and_call_original

    get :show, params: { id: deal_order.id, token: @token_buyer }
    expect(response_body['data']['attributes']['order_items']['data'][0]['attributes']['price']).to eq(seller_catalogue.current_offer_price)

  end
end

describe 'PATCH #update' do

  it 'updates the order status ordered' do
    user_address = create(:user_delivery_address, account: @customer)
    @order.update(address_id: user_address.id)
    allow_any_instance_of(BxBlockShoppingCart::Order).to receive(:update_shipping_address).and_call_original

    patch :update, params: { id: @order.id, orders: { status: @order_status_ordered.name, order_item_id: @order_item.id }, token: @token_buyer }
    expect(response).to have_http_status(:ok)
    expect(response_body['data']['attributes']['order_items']['data'][0]['attributes']['item']['catalogue']['data']['attributes']['purchased_count']).to eq(@order.catalogues.first.purchased_count)
    expect(response_body['data']['attributes']['shipping_address']['data']['attributes']['address_status']).to eq('ordered')
    expect(response_body['data']['attributes']['order_items']['data'][0]['attributes']['item']['catalogue']['data']['attributes']['parent_catalogue_id']).to be_present
  end

  it 'updates the order status ordered send mail to seller and buyer' do

   expect {
    perform_enqueued_jobs do
      patch :update, params: { id: @order.id, orders: { status: @order_status_ordered.name, order_item_id: @order_item.id }, token: @token_buyer }
    end
  }.to change { ActionMailer::Base.deliveries.count }.by(3)

end

it 'updates the order status deliveried send mail to seller and buyer' do

  expect {
    perform_enqueued_jobs do
      patch :update, params: { id: @order.id, orders: { status: @order_status_delivered.name, order_item_id: @order_item.id }, token: @token_buyer }

    end
  }.to change { ActionMailer::Base.deliveries.count }.by(3)
end

it 'updates the order status shipped send mail to seller and buyer' do

   expect {
    perform_enqueued_jobs do
      patch :update, params: { id: @order.id, orders: { status: @order_status_shipped.name, order_item_id: @order_item.id }, token: @token_buyer }
    end
  }.to change { ActionMailer::Base.deliveries.count }.by(2)
end

it 'updates the order status' do

  patch :update, params: { id: @order.id, orders: { status: @order_status_completed.name, order_item_id: @order_item.id }, token: @token_buyer }

  expect(response).to have_http_status(:ok)
  expect(response_body['data']['attributes']['order_status']['data']['attributes']['name']).to eq("Completed")
  data = JSON.parse(response.body)
  expect(data[:coupon_code]).to eq(nil)
  expect(BxBlockActivitylog::ActivityLog.find_by(user_email: @customer.email).action).to eq("Order Status updated")
end

it 'invalid if order_status' do
  patch :update, params: { id: @order.id, orders: { status: 'invalid_status', order_item_id: @order_item.id }, token: @token_seller }
  expect(response_body['errors']).to eq('Invalid order or order status')
  expect(response).to have_http_status(:unprocessable_entity)
end
end

describe 'post #apply_coupon_to_order' do
  it 'apply the coupon' do
    post :apply_coupon_to_order, params: { id: @order.id, token: @token_buyer, coupon_code: @coupon.code }

    expect(response).to have_http_status(:ok)
    expect(response_body['data']['attributes']['coupon_code']['data']['attributes']['code']).to eq(@coupon.code)
    expect(response_body['message']).to eq("coupon_code applied")
  end

  it 'returns errors if the apply coupon fails' do
    post :apply_coupon_to_order, params: { id: @order.id, token: @token_buyer, coupon_code: '' }

    expect(response).to have_http_status(:unprocessable_entity)
    expect(response_body).to include('errors')
  end
end

describe 'GET #index' do
  it 'returns a list of orders #index' do
    @order.update(order_status_id: @order_status_completed.id)
    get :index, params: { token: @token_buyer, filter_by: @order_status_completed.name, per_page: 10, page: 1 }

    expect(response).to have_http_status(:ok)
    expect(response_body['orders'].last['order_details']['total_fees']).to eq(@order.total_fees)
    expect(response_body['orders'].last['order_details']['order_item_details']).to have_key('selected_product_variant')
    expect(response_body['orders'].last['order_details']).to have_key('order_item_details')
    expect(response_body).to have_key('total_count')
  end

  it 'returns a list of orders #index filter' do
    @order.update(order_status_id: @order_status_completed.id)
    get :index, params: { token: @token_buyer, filter_by: 'history' }

    expect(response).to have_http_status(:ok)
    expect(response_body['orders'].last['order_details']['id']).to eq(@order.id)
  end

  it 'returns a list of orders #index filter array' do
    @order.update(order_status_id: @order_status_completed.id)
    get :index, params: { token: @token_buyer, filter_by: [@order_status_completed.name] }

    expect(response).to have_http_status(:ok)
    expect(response_body['orders'].last['order_details']['id']).to eq(@order.id)
  end

  it 'returns a list of orders with shippied address' do
    user_address = create(:user_delivery_address, account: @customer)
    @order.update(address_id: user_address.id)
    @order.update(order_status_id: @order_status_ordered.id)
    allow_any_instance_of(BxBlockShoppingCart::Order).to receive(:update_shipping_address).and_call_original

    get :index, params: {token: @token_buyer, filter_by: [@order_status_ordered.name]}
    @order.reload

    expect(response_body['orders'].last['order_details']['shipping_address']['data']['attributes']['address_status']).to eq(@order_status_ordered.status)
  end

  it 'returns a list of orders by order item status' do
    @order_item = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order)
    @order_item.update(order_status_id: @order_status_return.id)

    get :index, params: {token: @token_buyer, order_item_status: [@order_status_return.name]}
    @order.reload

    expect(response_body['orders'].last['order_details']['order_item_details']['order_status']['data']['attributes']['name']).to eq(@order_status_return.name)
  end
end

describe 'GET #seller_orders' do
  it 'returns a list of seller orders' do
    @order_1.update(order_status: @order_status_shipped)
    get :seller_orders, params: { token: @token_seller}

    expect(response).to have_http_status(:ok)
    expect(response_body[0]['order_id']).to eq(@order_1.id - 1)
    expect(response_body[0]['total_fees']).to eq(@order_1.total_fees)
    expect(response_body[0]['discount']).to eq(@order_1.discount.to_s)
  end

  it 'returns a list of seller orders by sort date_latest' do
    get :seller_orders, params: { token: @token_seller, sort_by: 'date_latest' }

      expect(response).to have_http_status(:ok)
      # expect(response_body[0]['id']).to eq(@order_1.id)
      expect(response_body[0]['total_fees']).to eq(@order_1.total_fees)
      expect(response_body[0]['discount']).to eq(@order_1.discount.to_s)
    end

    it 'returns a list of seller orders by sort date_oldest' do
      get :seller_orders, params: { token: @token_seller, sort_by: 'date_oldest' }

      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of seller orders by sort product_name_AZ' do
      get :seller_orders, params: { token: @token_seller, sort_by: 'product_name_AZ' }

      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of seller orders by sort product_name_ZA' do
      get :seller_orders, params: { token: @token_seller, sort_by: 'product_name_ZA' }

      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of seller orders by search query' do
      get :seller_orders, params: { token: @token_seller, search_query: "#{@order.order_number}" }

      expect(response).to have_http_status(:ok)
      expect(response_body[0]['order_id']).to eq(@order.id)
      expect(response_body[0]['total_fees']).to eq(@order.total_fees)
      expect(response_body[0]['discount']).to eq(@order.discount.to_s)
    end

    it 'returns a no seller orders' do
      get :seller_orders, params: { token: @token_seller, filter_by: 'inv_status' }

      expect(response).to have_http_status(:ok)
      expect(response_body['message']).to eq('No order present ')
    end
  end

  describe 'GET #show_seller_orders' do
    it 'returns a show of seller orders' do
      get :show_seller_order, params: { token: @token_seller, id: @order_1.id }

      expect(response).to have_http_status(:ok)
      expect(response_body[0]['order_id']).to eq(@order_1.id)
      expect(response_body[0]['total_fees']).to eq(@order_1.total_fees)
      expect(response_body[0]['discount']).to eq(@order_1.discount.to_s)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the order' do
      order = create(:shopping_cart_order, customer: @customer, order_status: @order_status)

      expect do
        delete :destroy, params: { id: order.id, token: @token_seller }
      end.to change { BxBlockShoppingCart::Order.count }.by(-1)

      expect(response).to have_http_status(:ok)
      expect(response_body['message']).to eq('order destroyed')
    end
  end

  describe 'DELETE #destroy_all_orders' do
    it 'destroys all orders and associated items' do
      order_de = create_list(:shopping_cart_order, 3, customer: @customer, order_status: @order_status)
      create_list(:shopping_cart_order_item, 5, catalogue: @catalogue, order: order_de.first)

      delete :destroy_all_orders, params: { token: @token_seller}

      expect(response).to have_http_status(:ok)
      expect(response_body['message']).to eq('Destroyed all orders')
    end

    it 'returns no orders present if no orders found' do
      BxBlockShoppingCart::Order.destroy_all
      delete :destroy_all_orders, params: { token: @token_seller}

      expect(response).to have_http_status(:ok)
      expect(response_body['message']).to eq('No orders present')
    end
  end

  private

  def response_body
    JSON.parse(response.body)
  end
end
