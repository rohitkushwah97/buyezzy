require 'rails_helper'

RSpec.describe BxBlockCatalogue::BrandsController, type: :controller do
  before do
    @account = FactoryBot.create(:account, user_type: 'seller')
    @account_2 = FactoryBot.create(:account)
    @token_2 = BuilderJsonWebToken.encode(@account_2.id, token_type: 'login')
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @brand = create("brand",account: @account, branding_tradmark_certificate: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "document.pdf")))
    @category = create(:category)
    @sub_category = create(:sub_category,category: @category)
    @err_msg = "Brand name has already been taken"
  end

  describe 'POST #create' do
    it 'creates a new brand' do
      brand_params = {
        brand_name: Faker::Lorem.word + rand(1..20000).to_s + Faker::Lorem.word,
        brand_name_arabic: 'Brand in Arabic',
        brand_website: 'https://www.example.com',
        brand_year: 2023,
        branding_tradmark_certificate: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "document.pdf")),
        brand_image: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "Sample.jpg"))
      }

      expect {
        post :create, params: brand_params.merge(token: @token)
      }.to change(BxBlockCatalogue::Brand, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['data']['attributes']['brand_name']).to eq(brand_params[:brand_name])
    end

    it 'create with invalid params' do
      brand_params = {brand_name: @brand.brand_name}
      expect {
        post :create, params: brand_params.merge(token: @token)
      }.to change(BxBlockCatalogue::Brand, :count).by(0)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors'][0]).to eq(@err_msg)
    end

    it 'create with same brand name as lower case(case sensitive)' do
      brand_params = {brand_name: @brand.brand_name.downcase}
      expect {
        post :create, params: brand_params.merge(token: @token)
      }.to change(BxBlockCatalogue::Brand, :count).by(0)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors'][0]).to eq(@err_msg)
    end
  end

  describe 'GET #index' do
    it 'returns a list of brands' do

      get :index, params: { token: @token }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].size).to eq(BxBlockCatalogue::Brand.all.count)
    end
  end

  describe 'GET #restricted_brands_index' do
    it 'returns a list of brands restricted' do

      get :restricted_brands_index, params: { token: @token }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].size).to eq(BxBlockCatalogue::Brand.all.where(restricted: true).count)
    end
  end

  describe 'GET #approved_brands_index' do
    it 'returns a list of brands approved' do

      get :approved_brands_index, params: { token: @token }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].size).to eq(BxBlockCatalogue::Brand.all.where(approve: true).count)
    end
  end

  describe 'GET #gated_brands_index' do
    it 'returns a list of brands gated' do
      get :gated_brands_index, params: { token: @token }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].size).to eq(BxBlockCatalogue::Brand.all.where(gated: true).count)
    end
  end

  describe "GET #search_brand" do
    it "returns matching brand based on the keyword search_brand" do
      keyword = @brand.brand_name

      get :search_brands, params: {token: @token, keyword: keyword}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
      expect(JSON.parse(response.body)[0]["id"]).to eq(@brand.id)
      expect(JSON.parse(response.body)[0]["brand_name"]).to eq(@brand.brand_name)
      expect(JSON.parse(response.body)[0]["current_owner"]).to eq(true)
      expect(JSON.parse(response.body)[0]["restricted_request_exist"]).to eq(false)
      expect(JSON.parse(response.body)[0]["permission_granted"]).to eq(false)
    end

    it "returns an empty list if no matching brand found" do
      keyword = "non_matching_keyword"

      get :search_brands, params: {token: @token, keyword: "some_keyword" }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["message"]).to eq("Brand not found")
    end

    it "returns an keyword missing error" do

      get :search_brands, params: {token: @token, keyword: "" }

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)["message"]).to eq("Keyword is missing")
    end
  end

  describe "GET #list brands from catalogues" do
    it "returns matching brand based on the keyword list" do
      category = FactoryBot.create(:category)  
      catalogue = FactoryBot.create(:catalogue, category: category, brand: @brand, status: true) 

      get :list_brands_from_catalogues, params: {token: @token, category_id: category.id}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"].size).to eq(1)
      expect(JSON.parse(response.body)["data"][0]["id"]).to eq(@brand.id.to_s)
      expect(JSON.parse(response.body)["data"][0]["attributes"]["brand_name"]).to eq(@brand.brand_name)
    end

    it "returns matching brand based on the keyword by deal" do
      catalogue1 = FactoryBot.create(:catalogue, brand: @brand, status: true) 
      deal = FactoryBot.create(:deal)
      deal_catalogue = FactoryBot.create(:deal_catalogue, deal: deal, catalogue: catalogue1, seller: @account, status: 'approved' )

      get :list_brands_from_catalogues, params: {token: @token, deal_id: deal.id}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"][0]["id"]).to eq(@brand.id.to_s)
      expect(JSON.parse(response.body)["data"][0]["attributes"]["brand_name"]).to eq(@brand.brand_name)
    end

    it "returns an empty list if no matching brand found list" do

      get :list_brands_from_catalogues, params: {token: @token, category_id: nil }

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)["message"]).to eq("Category ID or Deal ID is required")
    end
  end

  describe 'GET #show' do
    it 'returns brand' do

      get :show, params: { token: @token , id: @brand.id}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"]["attributes"]).to have_key("branding_tradmark_certificate")
      expect(JSON.parse(response.body)["data"]["attributes"]).to have_key("brand_image")
    end
  end

  describe 'GET #seller brands listing' do
    it 'user not authorized' do
      get :seller_brand_listing, params: { token: @token_2}
      expect(response).to have_http_status(:forbidden)
      expect(response.body).to eq("{\"errors\":[{\"message\":\"You are not authorized to access brands\"}]}")
    end

    it "get seller user's brands" do
      token = BuilderJsonWebToken.decode(@token)
      AccountBlock::Account.find_by(id: token.id)&.update(user_type: 'seller')
      get :seller_brand_listing, params: { token: @token}
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update_seller_brand' do
    # it 'user not authorized' do
    #   put :update_seller_brands, params: { token: @token}
    #   expect(response).to have_http_status(:forbidden)
    #   expect(response.body).to eq("{\"errors\":[{\"message\":\"You are not authorized to access brands\"}]}")
    # end

    it "update seller's brand" do
      token = BuilderJsonWebToken.decode(@token)
      AccountBlock::Account.find_by(id: token.id)&.update(user_type: 'seller')
      put :update_seller_brands, params: { token: @token, id: @brand.id}
      expect(response).to have_http_status(:ok)
    end

    it "not update seller's brand" do
      token = BuilderJsonWebToken.decode(@token)
      AccountBlock::Account.find_by(id: token.id)&.update(user_type: 'seller')
      put :update_seller_brands, params: { token: @token, id: @brand.id, brand_name: nil}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eq("{\"errors\":[\"Brand name can't be blank\"]}")
    end
  end

  describe 'POST #update_seller_brand' do
    it 'user not authorized' do
      post :create_seller_brand, params: { token: @token_2}
      expect(response).to have_http_status(:forbidden)
      expect(response.body).to eq("{\"errors\":[{\"message\":\"You are not authorized to access brands\"}]}")
    end

    it "create seller brand" do
      token = BuilderJsonWebToken.decode(@token)
      AccountBlock::Account.find_by(id: token.id)&.update(user_type: 'seller')
      post :create_seller_brand, params: { token: @token, brand_name: "lenovo", brand_name_arabic: "lenovo", brand_website: "https://example.com"}
      expect(response).to have_http_status(:created)
    end

    it "not create seller's brand" do
      token = BuilderJsonWebToken.decode(@token)
      AccountBlock::Account.find_by(id: token.id)&.update(user_type: 'seller')
      post :create_seller_brand, params: { token: @token,  brand_name: nil, brand_website: nil}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eq("{\"errors\":[\"Brand name can't be blank\",\"Brand website can't be blank\",\"Brand website is not valid url\"]}")
    end
  end

  describe 'DELETE #delete_seller_brand' do
    before do 
      @accountb = FactoryBot.create(:account, user_type: 'seller')
      @token_b = BuilderJsonWebToken.encode(@accountb.id, token_type: 'login')
      @brand_b = create(:brand)
      @brand_c = create(:brand)
      @catalogueb = create(:catalogue, brand: @brand_c)
    end

    it "delete seller brand" do
      delete :delete_seller_brand, params: { token: @token_b, id: @brand_b.id}
      expect(response).to have_http_status(:ok)
    end

    it "delete seller brand associated with catalogue" do
      delete :delete_seller_brand, params: { token: @token_b, id: @brand_c.id}
      expect(JSON.parse(response.body)["errors"][0]).to eq("Cannot delete brand because it is associated with products or store.")
    end
  end

  describe "GET #list_sub_categories_from_brand" do

    it "error message list_sub_categories_from_brand" do

      get :list_sub_categories_from_brand, params: {brand_id: nil}

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("subcategories not found")
    end

    it "returns a list of list_sub_categories_from_brand by brand" do

      brand = FactoryBot.create(:brand, approve: true)
      catalogue = FactoryBot.create(:catalogue, brand: brand, category: @category, sub_category: @sub_category, status: true) 
      get :list_sub_categories_from_brand, params: {brand_id: brand.id}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"].size).to eq(1)
      expect(JSON.parse(response.body)["data"][0]['id']).to eq(@sub_category.id.to_s)
    end
  end
end

