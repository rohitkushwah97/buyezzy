require 'rails_helper'

RSpec.describe BxBlockShoppingCart::OrderItemsController, type: :controller do
  include ActiveJob::TestHelper
  before do
    @customer = FactoryBot.create(:account, user_type: 'buyer')
    @customer_2 = FactoryBot.create(:account, user_type: 'buyer', first_name: "user")
    @account = FactoryBot.create(:account, user_type: 'seller')
    @token = BuilderJsonWebToken.encode(@customer.id, token_type: 'login')
    @order_status = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Return')
    @order_status_ordered = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Ordered')
    @order_statusr = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Refunded')
    @order_status_rejected = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Rejected')
    @order = create(:shopping_cart_order, customer: @customer)
    @catalogue = create(:catalogue, seller: @account)
    @catalogue_variant = create(:catalogue_variant, seller: @account)
    @product_variant_group = create(:product_variant_group, catalogue: @catalogue)
    @group_attributes = create_list(:group_attribute, 2, product_variant_group: @product_variant_group)
  end

  describe 'POST #create' do
    context 'when creating a new order item' do
      it 'creates a new order item for the customer' do
        post :create, params: { token: @token, order_items: { catalogue_id: @catalogue.id, quantity: 2, product_variant_group_id: @product_variant_group.id } }

        expect(response).to have_http_status(:created)
        expect(response_body['data']['attributes']['order_items']['data'][0]['attributes']['item']['catalogue']['data']['id']).to eq(@catalogue.id.to_s)
        expect(response_body['data']['attributes']['order_items']['data'][0]['attributes']['quantity']).to eq(@order.order_items.last.quantity)
        expect(response_body['data']['attributes']['order_items']['data'][0]['attributes']['item']['selected_product_variant']['id']).to eq(@product_variant_group.id)
        expect(response_body['data']['attributes']['order_items']['data'][0]['attributes']['item']['selected_product_variant']['group_attributes'][0]['attribute_name']).to eq(@product_variant_group.group_attributes.first.attribute_name)
      end
    end

    context 'when updating an existing order item' do
      before do
        @order_item = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order)
      end

      it 'updates the quantity of the existing order item in shopping_cart' do
        post :create, params: { token: @token, order_items: { catalogue_id: @catalogue.id, quantity: 3, shopping_cart: true } }

        expect(response).to have_http_status(:created)
        expect(response_body['data']['attributes']['order_items']['data'][0]['attributes']['item']['catalogue']['data']['id']).to eq(@catalogue.id.to_s)
        expect(response_body['data']['attributes']['order_items']['data'][0]['attributes']['quantity']).to eq(3)
      end

      it 'returns a error for quantity exceeding' do
        post :create, params: { token: @token, order_items: { catalogue_id: @catalogue.id, quantity: 6, shopping_cart: true } }
       expect(response_body).to include('data')
      end

      it 'updates the quantity of the existing order item' do
        post :create, params: { token: @token, order_items: { catalogue_id: @catalogue.id, quantity: 2} }

        expect(response_body['data']['attributes']['order_items']['data'][0]['attributes']['quantity']).to eq(4)
      end
    end

    context 'when order item creation fails' do
      it 'returns errors if creation fails' do
        post :create, params: { token: @token, order_items: { catalogue_id: nil, quantity: 2 } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body).to include('errors')
      end
    end
  end

  describe 'POST #guest_user_order' do
    context 'guest_user_order when creating a new order item' do
      it 'guest_user_order creates a new order item for the customer' do
        post :guest_user_order, params: { token: @token, order_items: [{ catalogue_id: @catalogue.id, quantity: 2, product_variant_group_id: @product_variant_group.id }] }

        expect(response).to have_http_status(:created)
        expect(response_body['order']['data']['attributes']['order_items']['data'][0]['attributes']['item']['catalogue']['data']['id']).to eq(@catalogue.id.to_s)
        expect(response_body['order']['data']['attributes']['order_items']['data'][0]['attributes']['quantity']).to eq(@order.order_items.last.quantity)
        expect(response_body['message']).to eq('Order items added successfully')
      end
    end

    context 'guest_user_order when updating an existing order item' do
      before do
        @order_item1 = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order)
      end

      it 'guest_user_order updates the quantity of the existing order item' do
        post :guest_user_order, params: { token: @token, order_items: [{ catalogue_id: @catalogue.id, quantity: 2}] }

        expect(response_body['order']['data']['attributes']['order_items']['data'][0]['attributes']['quantity']).to eq(@order_item1.reload.quantity)
      end

      it 'guest_user_order updates the quantity of the existing order item which exceeds the stocks' do
        post :guest_user_order, params: { token: @token, order_items: [{ catalogue_id: @catalogue.id, quantity: 10}] }

        expect(response_body['order']['data']['attributes']['order_items']['data'][0]['attributes']['quantity']).to eq(@catalogue.stocks)
      end
    end

    context 'guest_user_order when order item creation fails' do
      it 'guest_user_order returns errors if creation fails' do
        post :guest_user_order, params: { token: @token, order_items: [] }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['message']).to include('Provide valid products')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @order_item = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order)
    end

    it 'destroys an order item' do
      delete :destroy, params: { token: @token, id: @order_item.id }

      expect(response).to have_http_status(:ok)
      expect(response_body).to include('message' => 'Order items deleted successfully!')
    end

    it 'returns not found if the order item does not exist' do
      delete :destroy, params: { token: @token, id: 999 }

      expect(response).to have_http_status(:not_found)
    end

    context 'when order item deletion fails' do
      it 'returns errors if deletion fails' do
        allow_any_instance_of(BxBlockShoppingCart::OrderItem).to receive(:destroy).and_return(false)

        delete :destroy, params: { token: @token, id: @order_item.id }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body).to include('errors')
      end
    end
  end

  describe 'PATCH #update' do
    before do
      @order_1 = create(:shopping_cart_order, customer: @customer)
      @order_statusc = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Cancelled')
      @order_statusin = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Refund Initiated')
      @order_statuspick = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Pickup Initiated')
      @order_item = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order_1)
    end
    it 'updates the order status' do

      patch :update, params: { id: @order_item.id, order_status_id: @order_statusc.id, token: @token }

      expect(response).to have_http_status(:ok)
      expect(response_body['data']['attributes']['order_status']['data']['attributes']['name']).to eq(@order_statusc.name)
    end

    it 'updates the order status to return send mail to seller' do
      expect {
        perform_enqueued_jobs do
          patch :update, params: { id: @order_item.id, order_status_id: @order_status.id, token: @token }
        end
      }.to change { ActionMailer::Base.deliveries.count }.by(2)
      expect(response).to have_http_status(:ok)
    end

    it 'updates the order status to pick up send mail to seller or buyer' do
      expect {
        perform_enqueued_jobs do
          patch :update, params: { id: @order_item.id, order_status_id: @order_statuspick.id, token: @token }
        end
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'updates the order status to return Initiated send mail to seller or buyer' do
      expect {
        perform_enqueued_jobs do
          patch :update, params: { id: @order_item.id, order_status_id: @order_statusin.id, token: @token }
        end
        }.to change { ActionMailer::Base.deliveries.count }.by(2)
    end

    it 'updates the order status to refunded send mail to seller' do
      expect {
        perform_enqueued_jobs do
          patch :update, params: { id: @order_item.id, order_status_id: @order_statusr.id, token: @token }
        end
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'invalid if order_status' do
      patch :update, params: { id: @order_item.id, order_status_id: 'invalid_status', token: @token }
      expect(response_body['message']).to eq("Order status not found")
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #seller_orders' do
    before do
      @order_0 = create(:shopping_cart_order, customer: @customer, order_status: @order_status)
      @seller = FactoryBot.create(:account, company_or_store_name: "byezzy", user_type: 'seller')
      @token_seller = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
      @catalogue_1 = create(:catalogue, seller: @account)
      @product_content = create(:product_content, catalogue: @catalogue_1)
      @order_item_0 = create(:shopping_cart_order_item, catalogue: @catalogue_1, order: @order_0, order_status: @order_status)
      @order_1 = create(:shopping_cart_order, customer: @customer)
      @order_1.update(order_status: @order_status_ordered)
      @order_1.update(order_status: @order_status)
      @order_item_1 = create(:shopping_cart_order_item, catalogue: @catalogue_1, order: @order_1, order_status: @order_status_rejected)
      @return_exchange_request = create(:return_exchange_request, order: @order_1, customer: @customer)
      @return_reason_detail = create(:return_reason_detail, order_item: @order_item_1 )
    end

    it 'returns a list of seller orders' do
      @order_item_1.update(order_status: @order_status_rejected)
      @return_exchange_request.order_items << @order_item_1
      @return_exchange_request.save
      @order_item_1.reload
      get :index, params: { token: @token_seller, filter_by: ['rejected'] }

      expect(response).to have_http_status(:ok)
      expect(response_body['orders'][0]['order_details']['id']).to eq(@order_1.id)
      expect(response_body['orders'][0]['order_details']['total_fees']).to eq(@order_1.total_fees)
      expect(response_body['orders'][0]['order_details']['discount']).to eq(@order_1.discount)
      expect(response_body['orders'][0]['order_details']['time_passed_since_order_placed']).to eq(distance_of_time_in_words(@order_1.order_placed_at, Time.now))
      expect(response_body['orders'][0]['order_details']['order_item_details']['id']).to eq(@order_item_1.id)
      expect(response_body['orders'][0]['order_details']['return_exchange_requests'][0]['request_reason']).to eq(@return_exchange_request.request_reason)
      expect(response_body['orders'][0]['order_details']['return_reason_details'][0]['details']).to eq(@return_reason_detail.details)
    end

    it 'returns a list of seller orders by sort date_latest' do
      get :index, params: { token: @token_seller, sort_by: 'date_latest', filter_by: ['rejected','review'] }

      expect(response).to have_http_status(:ok)
      # expect(response_body[0]['id']).to eq(@order_1.id)
      expect(response_body['orders'][0]['order_details']['total_fees']).to eq(@order_1.total_fees)
      expect(response_body['orders'][0]['order_details']['discount']).to eq(@order_1.discount)
    end

    it 'returns a list of seller orders by sort date_oldest' do
      get :index, params: { token: @token_seller, sort_by: 'date_oldest', filter_by: ['rejected','review'] }

      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of seller orders by sort product_name_AZ' do
      get :index, params: { token: @token_seller, sort_by: 'product_name_AZ', filter_by: ['rejected','review'] }

      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of seller orders by sort product_name_ZA' do
      get :index, params: { token: @token_seller, sort_by: 'product_name_ZA', filter_by: ['rejected','review'] }

      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of seller orders by search query' do
      get :index, params: { token: @token_seller, search_query: @catalogue_1.sku, filter_by: ['rejected','review'] }

      expect(response).to have_http_status(:ok)
      expect(response_body['orders'][0]['order_details']['id']).to eq(@order_1.id)
      expect(response_body['orders'][0]['order_details']['total_fees']).to eq(@order_1.total_fees)
      expect(response_body['orders'][0]['order_details']['discount']).to eq(@order_1.discount)
    end

    it 'returns a no seller orders' do
      get :index, params: { token: @token_seller, filter_by: ['inv_status'] }

      expect(response).to have_http_status(:ok)
      expect(response_body['orders']['message']).to eq('No return orders')
    end
  end

  private

  def response_body
    JSON.parse(response.body)
  end
end
