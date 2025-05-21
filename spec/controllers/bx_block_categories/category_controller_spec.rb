require 'rails_helper'

RSpec.describe BxBlockCategories::CategoriesController, type: :controller do

  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @category = create(:category)
  end

  describe "GET #index" do
    it "returns a list of categories" do

      get :index, params: {token: @token}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"].size).to eq(BxBlockCategories::Category.count)
    end
  end

  describe "GET #show" do
    it "returns a single category" do

      get :show, params: { token: @token,id: @category.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"]["id"]).to eq(@category.id.to_s)
      expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq(@category.name)
      expect(JSON.parse(response.body)["data"]["attributes"]).to have_key("category_image")
      expect(JSON.parse(response.body)["data"]["attributes"]).to have_key("header_image")
    end

    it "returns an error if category does not exist" do
      non_existent_id = 0

      get :show, params: { token: @token, id: non_existent_id }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["message"]).to eq("Category doesn't exists")
    end
  end

  describe "GET #search_micro_categories" do
    category_1 = FactoryBot.create(:category)
    sub_category = FactoryBot.create(:sub_category, category: category_1)
    mini_category = FactoryBot.create(:mini_category, sub_category: sub_category)
    micro_category = FactoryBot.create(:micro_category, mini_category: mini_category)
    it "returns a list of micro_categories" do

      get :search_micro_categories, params: {search_query: micro_category.name}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"][0]["attributes"]["name"]).to eq(micro_category.name)
    end

    it "returns a list of micro_categories by category keyword" do

      get :search_micro_categories, params: {search_query: category_1.name}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"][0]["attributes"]["category_id"]).to eq(category_1.id)
    end
  end
end
