require 'rails_helper'

RSpec.describe Admin::TrendingProductsController, type: :controller do  
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @seller = create(:account, user_type: 'seller')
    @catalogues = create_list(:catalogue,6, seller: @seller)
    trending_product_selections_attributes = @catalogues.map do |catalogue|
      { catalogue_id: catalogue.id }
    end
    @trending_product = create(:trending_product, slider: 'slider_1', trending_product_selections_attributes: trending_product_selections_attributes)
    @params_tp = {slider: 'slider_2', trending_product_selections_attributes: trending_product_selections_attributes}
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: @trending_product.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

end
