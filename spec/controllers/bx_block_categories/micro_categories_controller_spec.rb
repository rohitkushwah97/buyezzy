require 'rails_helper'

RSpec.describe BxBlockCategories::MicroCategoriesController, type: :controller do

  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @category = create(:category)
    @sub_category = create(:sub_category,category: @category)
    @mini_categories = create_list(:mini_category, 2, sub_category: @sub_category)
    @micro_categories = create_list(:micro_category,2, mini_category: @mini_categories.first)
  end

  describe "GET #index" do
    it "returns a list of micro categories" do

      get :index, params: {token: @token,category_id: @category.id, sub_category_id: @sub_category.id, mini_category_id: @mini_categories.first}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"].size).to eq(@mini_categories.first.micro_categories.count)
    end
  end

  describe "GET #show" do
    it "returns a single micro_category" do

      get :show, params: { token: @token, category_id: @category.id, sub_category_id: @sub_category.id, mini_category_id: @mini_categories.first, id: @micro_categories.first.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"]["id"]).to eq(@micro_categories.first.id.to_s)
      expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq(@micro_categories.first.name)
    end

    it "returns an error if micro_category does not exist" do
      non_existent_id = 999

      get :show, params: { token: @token,category_id: @category.id,sub_category_id: @sub_category.id, mini_category_id: @mini_categories.first, id: non_existent_id }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["message"]).to eq("MicroCategory doesn't exists")
    end
  end

  describe "GET #list_microcategories_by_minicategory_ids" do
    it "returns a list of micro categories by mini categories" do

      get :list_microcategories_by_minicategory_ids, params: {mini_category_ids: [@mini_categories.first.id]}

      expect(JSON.parse(response.body)["data"].size).to eq(@mini_categories.first.micro_categories.count)
    end
  end

end
