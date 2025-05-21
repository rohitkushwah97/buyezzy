require 'rails_helper'

RSpec.describe Admin::OrderItemsController, type: :controller do
  render_views

  let(:admin_user) { FactoryBot.create(:admin_user) }
  let(:seller) { FactoryBot.create(:account, company_or_store_name: "byezzy") }
  let(:customer) { FactoryBot.create(:account) }
  let(:catalogue) { create(:catalogue, seller: seller) }
  let(:order_status) { BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'on_going') }
  let(:order) { FactoryBot.create(:shopping_cart_order, customer: customer, order_status: order_status) }
  let(:order_item) { FactoryBot.create(:shopping_cart_order_item, catalogue: catalogue, order: order) }

  before do
    sign_in admin_user
  end

  # describe 'GET #index' do
  #   it 'renders the index template' do
  #     get :index
  #     expect(response).to render_template(:index)
  #   end
  # end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: order_item.id }
      expect(response).to render_template(:show)
      expect(response.body).to include(order_item.id.to_s)
      expect(response.body).to include(order_item.quantity.to_s)
      expect(response.body).to include(order_item.price.to_s)
      expect(response.body).to include("Catalogue Details")
      expect(response.body).to include(catalogue.id.to_s)
      expect(response.body).to include(catalogue.sku)
      expect(response.body).to include(catalogue.besku)
    end
  end
end