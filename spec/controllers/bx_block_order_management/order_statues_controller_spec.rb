require 'rails_helper'
RSpec.describe BxBlockOrderManagement::OrderStatuesController, type: :controller do
  
  let (:order_status) {create(:order_status)}
  let(:account) { FactoryBot.create(:account) }
  before(:each) do
    @token = BuilderJsonWebToken.encode(account.id)
  end

  describe 'GET#OrderStatus Listing' do
    context 'list of order_statuses' do
      it 'should return  order_statuses' do 
        get :index, params: { token: @token }
        expect(response).to have_http_status :ok
      end
    end
  end

  describe 'GET# Show Order status' do
    context 'Show  order_status' do
      it 'should show order_status' do 
        get :show, params: { token: @token, id: order_status.id }
        expect(response).to have_http_status :ok
      end
    end
  end
end