require 'rails_helper'

RSpec.describe BxBlockCategories::MiniCategoriesController, type: :controller do

  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @category = create(:category)
    @sub_category = create(:sub_category,category: @category)
    @mini_categories = create_list(:mini_category, 2, sub_category: @sub_category)
    @micro_categories = create_list(:micro_category,2, mini_category: @mini_categories.first)
  end

  describe "GET #index" do
    it "returns a list of mini categories" do

      get :index, params: {token: @token,category_id: @category.id, sub_category_id: @sub_category.id}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"].size).to eq(@sub_category.mini_categories.count)
    end
  end

  describe "GET #show" do
    it "returns a single mini_category" do

      get :show, params: { token: @token, category_id: @category.id, sub_category_id: @sub_category.id, id: @mini_categories.first.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"]["id"]).to eq(@mini_categories.first.id.to_s)
      expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq(@mini_categories.first.name)
      expect(JSON.parse(response.body)["data"]["attributes"]["micro_categories"].first['id']).to eq(@micro_categories.first.id)
    end

    it "returns an error if mini_category does not exist" do
      non_existent_id = 999

      get :show, params: { token: @token,category_id: @category.id,sub_category_id: @sub_category.id, id: non_existent_id }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["message"]).to eq("MiniCategory doesn't exists")
    end
  end

  describe "GET #list_minicategories_by_subcategory_ids" do
    it "returns a list of mini categories by sub categories" do

      get :list_minicategories_by_subcategory_ids, params: {sub_category_ids: [@sub_category.id]}

      expect(JSON.parse(response.body)["data"].size).to eq(@sub_category.mini_categories.count)
    end
  end

end
