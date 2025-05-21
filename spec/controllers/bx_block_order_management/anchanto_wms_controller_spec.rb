require 'rails_helper'

RSpec.describe BxBlockOrderManagement::AnchantoWmsController, type: :controller do
  let(:seller) { create(:account, user_type: 'seller') }
  let(:buyer) { create(:account, user_type: 'buyer') }
  let(:buytoken) { BuilderJsonWebToken.encode(buyer.id) }
  let(:catalogue) { create(:catalogue, seller: seller, fulfilled_type: 'byezzy') }
  let(:order_status) { BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Ordered') }
  let(:order) { create(:shopping_cart_order, customer: buyer, order_status: order_status) }
  let(:product_content) { create(:product_content, catalogue: catalogue) }
  let(:order_item) { create(:shopping_cart_order_item, catalogue: catalogue, order: order) }
  let(:product_content) { create(:product_content, catalogue: catalogue) }
  let(:token) { BuilderJsonWebToken.encode(seller.id) }
  let(:valid_auth_token) { 'valid_auth_token' }
  let(:valid_warehouse_code) { 'WH123' }
  let(:wms_product_info) { create(:wms_product_info, seller: seller, catalogue: catalogue) }
  let(:consignment_api) { 'https://uatapi.anchanto.com/rest/v1/consignments' }
  let(:order1) { create(:shopping_cart_order, customer: buyer, order_status: order_status) }
  let(:not_found_msg) { 'Order not found' }

  describe 'POST #create_wms_product' do
    context 'with valid params and successful response from WMS API' do
      let(:valid_wms_response) do
        {
          'response' => 'success',
          'message' => 'Product created',
          'data' => [
            { 'product_information_id' => [6] },
            { 'product_dimensions_info' => { 'sku-test-wms' => 6 } }
          ]
        }.to_json
      end

      before do
        stub_request(:post, 'https://uatapi.anchanto.com/rest/v1/products')
          .to_return(status: 200, body: valid_wms_response)
      end

      it 'creates a WmsProductInfo and returns success response' do
        expect do
          post :create_wms_product,
               params: { authorization: valid_auth_token, warehouse_code: valid_warehouse_code, catalogue_id: catalogue.id,
                         token: token }
        end.to change(BxBlockOrderManagement::WmsProductInfo, :count).by(1)

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['response']).to eq('success')
        expect(parsed_response['message']).to eq('Product created')
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable entity status' do
        post :create_wms_product, params: { token: token, catalogue_id: nil }

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('Catalogue not found')
      end

      it 'returns an unprocessable entity status for invalid seller' do
        post :create_wms_product, params: { token: buytoken, catalogue_id: nil }

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('Invalid seller')
      end
    end

    context 'with an invalid response from the WMS API' do
      let(:invalid_wms_response) do
        {
          'response' => 'failure',
          'message' => 'Product could not be created',
          'data' => ['Base uom dimension is required']
        }.to_json
      end

      before do
        stub_request(:post, 'https://uatapi.anchanto.com/rest/v1/products')
          .to_return(status: 400, body: invalid_wms_response)
      end

      it 'does not create WmsProductInfo and returns error response' do
        expect do
          post :create_wms_product,
               params: { token: token, authorization: valid_auth_token, warehouse_code: valid_warehouse_code,
                         catalogue_id: catalogue.id }
        end.not_to change(BxBlockOrderManagement::WmsProductInfo, :count)

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['response']).to eq('failure')
        expect(parsed_response['message']).to eq('Product could not be created')
      end
    end
  end

  describe 'POST #create_consignment_order' do
    let(:valid_consignment_order_response) do
      {
        "response": 'success',
        "message": 'Consignment created',
        "order_number": 'POBTUSER123520835451308',
        "data": []
      }.to_json
    end

    before do
      stub_request(:post, consignment_api)
        .to_return(status: 200, body: valid_consignment_order_response)
    end

    it 'creates a consignment order and returns success response' do
      expect do
        post :create_consignment_order,
             params: { authorization: valid_auth_token, quantity: 1, warehouse_code: valid_warehouse_code,
                       catalogue_id: catalogue.id, token: token }
      end.to change(BxBlockOrderManagement::WmsConsignmentOrder, :count).by(1)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['response']).to eq('success')
      expect(parsed_response['message']).to eq('Consignment created')
      expect(parsed_response['order_number']).to eq('POBTUSER123520835451308')
    end
  end

  describe 'POST #create_consignment_order with invalid params' do
    before do
      stub_request(:post, consignment_api)
        .to_return(status: 401, body: { message: 'Missing required params' }.to_json)
    end

    it 'returns an unprocessable entity status consign order' do
      post :create_consignment_order,
           params: { token: token, authorization: '', warehouse_code: '', quantity: 1, catalogue_id: catalogue.id }

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq('Missing required params')
    end

    it 'returns an unprocessable entity quantity error' do
      post :create_consignment_order,
           params: { token: token, authorization: 'adf', warehouse_code: 'asd', quantity: '',
                     catalogue_id: catalogue.id }

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq('Missing quantity')
    end

    it 'returns an unprocessable entity status for invalid seller consign order' do
      post :create_consignment_order,
           params: { token: buytoken, authorization: '', warehouse_code: '', catalogue_id: catalogue.id }

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq('Invalid seller')
    end
  end

  describe 'POST #create_consignment_order with invalid response from WMS API' do
    let(:invalid_consignment_order_response) do
      {
        "errors": 'Warehouse mismatch!'
      }.to_json
    end

    before do
      stub_request(:post, consignment_api)
        .to_return(status: 401, body: invalid_consignment_order_response)
    end

    it 'returns an error response and does not create a consignment order' do
      post :create_consignment_order,
           params: { token: token, authorization: valid_auth_token, warehouse_code: '', quantity: 1,
                     catalogue_id: catalogue.id }

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['errors']).to eq('Warehouse mismatch!')
    end
  end

  describe 'POST #create_b2c_order' do
    context 'with valid params and successful response from WMS Order API' do
      let(:valid_wms_api_order_response) do
        {
          "response": 'success',
          "message": 'Order created',
          "order_number": order.order_number,
          "data": [],
          "state": 'draft'
        }.to_json
      end

      before do
        order.order_items << order_item
        stub_request(:post, 'https://uatapi.anchanto.com/rest/v1/b2c/orders')
          .to_return(status: 200, body: valid_wms_api_order_response)
      end

      it 'creates a WmsB2cOrder and returns success response' do
        post :create_b2c_order,
             params: { authorization: valid_auth_token, warehouse_code: valid_warehouse_code, order_id: order.id,
                       token: token }

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['response']).to eq('success')
        expect(parsed_response['message']).to eq('Order created')
      end
    end

    context 'with invalid params Wms Order API' do
      it 'returns an unprocessable entity status' do
        post :create_b2c_order, params: { token: token, order_id: nil }

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq(not_found_msg)
      end
    end

    context 'with invalid Wms Order API' do
      it 'returns an not found status' do
        post :create_b2c_order, params: { token: token, order_id: order1.id }

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('No byezzy products ordered')
      end
    end
  end

  describe 'GET #b2c_order_index' do
    let(:external_response) do
      {
        "data": [
          {
            "attributes": {
              "number": '1',
              "state": 'draft',
              "order_items": [
                { "sku": catalogue.bibc, "paid_price": '3500.0', "quantity": 1 }
              ]
            }
          }
        ],
        "meta": { "current_page": 1, "total_pages": 1, "total_count": 1 }
      }.to_json
    end

    before do
      stub_request(:get, 'https://uatapi.anchanto.com/rest/v1/b2c/orders?filter[created_at]=&page[number]=1&page[size]=10')
        .to_return(status: 200, body: external_response)
    end

    context 'when the request is successful' do
      it 'returns filtered orders for the seller' do
        post :b2c_order_index,
             params: { per_page: 10, page: 1, authorization: valid_auth_token, warehouse_code: valid_warehouse_code,
                       token: token }

        expect(response).to have_http_status(:ok)
        response_body = JSON.parse(response.body)

        expect(response_body['orders'].size).to eq(1)
        expect(response_body['orders'][0]['order_items'].size).to eq(1)
        expect(response_body['orders'][0]['order_items'][0]['sku']).to eq(catalogue.bibc)
      end
    end

    context 'when the request fails' do
      before do
        stub_request(:get, 'https://uatapi.anchanto.com/rest/v1/b2c/orders?filter[created_at]=&page[number]=1&page[size]=10')
          .to_return(status: 500, body: { message: 'Internal Server Error' }.to_json)
      end

      it 'returns an error response' do
        post :b2c_order_index,
             params: { per_page: 10, page: 1, authorization: valid_auth_token, warehouse_code: valid_warehouse_code,
                       token: token }

        expect(response).to have_http_status(:internal_server_error)
        response_body = JSON.parse(response.body)

        expect(response_body['message']).to eq('Internal Server Error')
      end
    end
  end

  describe 'GET #b2c_order_show' do
    let(:external_response) do
      {
        "data": {
          "attributes": {
            "number": 1,
            "state": 'draft',
            "order_items": [
              { "sku": catalogue.bibc, "paid_price": '3500.0', "quantity": 1 }
            ]
          }
        },
        "meta": {}
      }.to_json
    end

    context 'when the request is successful' do
      before do
        stub_request(:get, 'https://uatapi.anchanto.com/rest/v1/b2c/orders/1/details')
          .to_return(status: 200, body: external_response)
      end
      it 'returns the order details filtered by seller' do
        post :b2c_order_show,
             params: { order_number: 1, authorization: valid_auth_token, warehouse_code: valid_warehouse_code,
                       token: token }

        expect(response).to have_http_status(:ok)
        response_body = JSON.parse(response.body)

        expect(response_body['orders'].size).to eq(0)
        # expect(response_body["orders"][0]["order_items"].size).to eq(1)
        # expect(response_body["orders"][0]["order_items"][0]["sku"]).to eq(catalogue.bibc)
      end
    end

    context 'when the request fails' do
      before do
        stub_request(:get, 'https://uatapi.anchanto.com/rest/v1/b2c/orders/1/details')
          .to_return(status: 404, body: { message: not_found_msg }.to_json)
      end

      it 'returns an error response' do
        post :b2c_order_show,
             params: { order_number: 1, authorization: valid_auth_token, warehouse_code: valid_warehouse_code,
                       token: token }

        expect(response).to have_http_status(:not_found)
        response_body = JSON.parse(response.body)

        expect(response_body['message']).to eq(not_found_msg)
      end
    end
  end

  let(:event_params) do
    {
      event_parameters: {
        warehouse_code: 'WH123',
        seller_email: seller.email,
        api_key: 'some_api_key'
      },
      event: {
        order_number: 'ORD123',
        old_state: 'pending',
        new_state: 'shipped',
        event_on: '2024-11-05 12:40:12 +0000',
        time_zone: 'UTC'
      },
      products: [
        { sku: catalogue.bibc, quantity: 10, batch: 'BATCH001', expiry_date: '2025-12-31', usable_quantity: 8 }
      ]
    }
  end

  describe 'POST #event_grn_status_update_in_wms' do
    it 'processes the WMS event and creates records' do
      expect do
        post :event_grn_status_update_in_wms, params: event_params
      end.to change(BxBlockOrderManagement::WmsEventUpdate, :count).by(1)

      created_event = BxBlockOrderManagement::WmsEventUpdate.last
      expect(created_event.warehouse_code).to eq('WH123')
      expect(created_event.seller_email).to eq(seller.email)
      expect(created_event.products).to be_present
      expect(response).to have_http_status(:ok)
    end

    it 'notifies the seller with the correct details' do
      post :event_grn_status_update_in_wms, params: event_params
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end

  describe 'POST #event_consignment_status_update_in_wms' do
    it 'processes the consignment event and creates records' do
      expect do
        post :event_consignment_status_update_in_wms, params: event_params
      end.to change(BxBlockOrderManagement::WmsEventUpdate, :count).by(1)

      created_event = BxBlockOrderManagement::WmsEventUpdate.last
      expect(created_event.seller_email).to eq(seller.email)
    end
  end

  describe 'POST #event_b2c_shipment_status_update_in_wms' do
    it 'processes the B2C shipment event and creates records' do
      expect do
        post :event_b2c_shipment_status_update_in_wms, params: event_params
      end.to change(BxBlockOrderManagement::WmsEventUpdate, :count).by(1)

      created_event = BxBlockOrderManagement::WmsEventUpdate.last
      expect(created_event.time_zone).to eq('UTC')
    end
  end
end
