require 'rails_helper'

RSpec.describe Admin::OrderStatusesController, type: :controller do
  render_views
  let(:valid_attributes) do
    {
      name: Faker::Lorem.characters(number: 10).gsub(/\d/, '').upcase
    }
  end
  before do
    @admin = FactoryBot.create(:admin_user)
    @order_status = FactoryBot.create(:order_status)
    sign_in @admin
    @order_statuses = create_list(:order_status, 2)
  end

  describe 'GET #index' do
    it 'returns a success index response' do
      get :index
      expect(response).to render_template(:index)
       @order_statuses.each do |order_status|
          expect(response.body).to include(order_status.name)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success show response' do
      get :show, params: { id: @order_status.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'returns a success new response' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "UPDATE#order status" do
    it 'should update order status' do
      put :update, params: {id: @order_status.id, order_status: valid_attributes }
      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE #order status" do
    it 'should delete order status' do
      delete :destroy, params: { id: @order_status.id }
      expect(response).to have_http_status(302)
    end
  end
end