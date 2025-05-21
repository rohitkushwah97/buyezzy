require 'rails_helper'

RSpec.describe BxBlockCategories::SubCategoriesController, type: :controller do

  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @category = create(:category)
    @sub_category = create(:sub_category,category: @category)
    @mini_categories = create_list(:mini_category, 2, sub_category: @sub_category)
    @micro_categories = create_list(:micro_category,2, mini_category: @mini_categories.first)
  end

  describe "GET #index" do
    it "returns a list of sub categories" do

      get :index, params: {token: @token,category_id: @category.id}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"].size).to eq(@category.sub_categories.count)
    end
  end

  describe "GET #show" do
    it "returns a single sub_category" do

      get :show, params: { token: @token, category_id: @category.id, id: @sub_category.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"]["id"]).to eq(@sub_category.id.to_s)
      expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq(@sub_category.name)
      expect(JSON.parse(response.body)["data"]["attributes"]["mini_categories"].first['id']).to eq(@mini_categories.first.id)
      expect(JSON.parse(response.body)["data"]["attributes"]["mini_categories"].first['micro_categories'].first['id']).to eq(@micro_categories.first.id)
    end

    it "returns an error if sub_category does not exist" do
      non_existent_id = 999

      get :show, params: { token: @token,category_id: @category.id, id: non_existent_id }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["message"]).to eq("SubCategory doesn't exists")
    end

    it "returns an error if category does not exist" do
      non_existent_id_cat = 993

      get :show, params: { token: @token,category_id: non_existent_id_cat, id: @sub_category.id }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["errors"][0]).to eq("Record not found")
    end
  end

  describe "GET #list_sub_categories_from_catalogues" do
    it "returns a list of list_sub_categories_from_catalogues" do
      catalogue = FactoryBot.create(:catalogue, category: @category, sub_category: @sub_category, status: true) 
      deal = FactoryBot.create(:deal)
      deal_catalogue = FactoryBot.create(:deal_catalogue, deal: deal, catalogue: catalogue, seller: @account, status: 'approved' )

      get :list_sub_categories_from_catalogues, params: {deal_id: deal.id}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"].size).to eq(1)
      expect(JSON.parse(response.body)["data"][0]['id']).to eq(@sub_category.id.to_s)
    end

    it "error message list_sub_categories_from_catalogues" do

      get :list_sub_categories_from_catalogues, params: {deal_id: nil}

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Deal not found")
    end
  end

  describe "GET #list_subcategories_by_category_ids" do
    it "returns a list of sub categories by category" do

      get :list_subcategories_by_category_ids, params: {category_ids: [@category.id]}

      expect(JSON.parse(response.body)["data"].size).to eq(@category.sub_categories.count)
    end
  end

end
