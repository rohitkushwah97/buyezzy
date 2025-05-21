require 'rails_helper'

RSpec.describe BxBlockCatalogue::DealCataloguesController, type: :controller do
  before do
    @account = FactoryBot.create(:account, user_type: 'seller')
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @deal = create(:deal, status: true)
    @catalogue = create(:catalogue)
    @product_content = create(:product_content, catalogue: @catalogue)
    @deal_catalogue = create(:deal_catalogue, deal: @deal, catalogue: @catalogue, seller: @account)
    @catalogue_2 = create(:catalogue, seller: @account)
    @catalogue_3 = create(:catalogue, seller: @account)
    @catalogue_4 = create(:catalogue, seller: @account)
    @product_content2 = create(:product_content, catalogue: @catalogue_2)
    @product_content3 = create(:product_content, catalogue: @catalogue_3)
    @product_content4 = create(:product_content, catalogue: @catalogue_4)
    @offer1 = create(:catalogue_offer, catalogue: @catalogue_2)
    @offer2 = create(:catalogue_offer, catalogue: @catalogue_3)
    @deal2 = create(:deal, discount_type: "flat", discount_value: 10, status: true)
    @deal_catalogue2 = create(:deal_catalogue, deal: @deal2, catalogue: @catalogue_4, seller: @account)
  end

  let(:deal_catalogue_params) do {
        seller_deals: [{
          catalogue_id: @catalogue_3.id,
          deal_price: "0",
          seller_id: @account.id
        }]
      } 
    end

  describe "GET #index" do
    it "returns a list of deal catalogues" do
      @deal_catalogues = create_list(:deal_catalogue,2, deal: @deal, catalogue: @catalogue_2, seller: @account, status: 2)
      get :index, params: { token: @token, deal_id: @deal.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"].size).to eq(3)
    end
  end

  describe "GET #show" do
    it "returns a deal catalogue" do

      get :show, params: { token: @token, deal_id: @deal.id, id: @deal_catalogue.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"]["id"]).to eq(@deal_catalogue.id.to_s)
    end

    it "returns a not found message if deal catalogue does not exist" do
      non_existent_id = 999

      get :show, params: { token: @token, deal_id: @deal.id, id: non_existent_id }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["message"]).to eq("Deal Catalogue not found")
    end
  end

  describe "POST #create" do
    it "creates a new deal catalogue" do
      post :create, params: deal_catalogue_params.merge(token: @token, deal_id: @deal.id)

      expect(response).to have_http_status(:created)
    end

    it "creates a new deal catalogue flat" do
      # if @deal.discount_type == 'flat'
      #   deal_catalogue_params[:seller_deals] = deal_catalogue_params[:seller_deals].map do |param|
      #     param.merge(deal_price: @deal.discount_value)
      #   end
      # end

      post :create, params: deal_catalogue_params.merge(token: @token, deal_id: @deal.id)

      expect(JSON.parse(response.body)['data'][0]['attributes']['current_offer_price']).to eq(@offer1.sale_price.to_s)
      expect(JSON.parse(response.body)['data'][0]['attributes']['deal_id']).to eq(@deal.id)
    end

    it "returns errors if deal catalogue creation fails" do
      catalogue_4 = create(:catalogue, seller: @account)
      invalid_params = {
        seller_deals: [{
          catalogue_id: catalogue_4.id,
          deal_price: 0.0,
          seller_id: @account.id
        },
        {
          catalogue_id: catalogue_4.id,
          deal_price: 0.0,
          seller_id: ""
        }]
      }

      post :create, params: invalid_params.merge(token: @token, deal_id: @deal.id)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["error"]).to include("Validation failed: Seller must exist")
    end

    it "returns errors if deal catalogue already exists" do
      catalogue_5 = create(:catalogue, seller: @account)
      deal_catalogue2 = create(:deal_catalogue, deal: @deal, catalogue: catalogue_5, seller: @account)

      invalid_params2 = {
        seller_deals: [{
          catalogue_id: catalogue_5.id,
          deal_price: "234",
          seller_id: @account.id
        }]
      }

      patch :create, params: invalid_params2.merge(token: @token, deal_id: @deal.id)

      expect(JSON.parse(response.body)["error"]).to include("A deal for this product already exists and is either in review, approved, or there is an active offer.")
    end
  end

  describe "PATCH #update" do
    updated_deal_price = "250.0"
    let(:update_params) { {
        data: {
          attributes: {
            deal_price: updated_deal_price
          }
        }
      } }
    it "updates a deal catalogue" do

      patch :update, params: update_params.merge(token: @token, deal_id: @deal2.id, id: @deal_catalogue2.id)

      expect(response).to have_http_status(:ok)
      expect(@deal_catalogue2.reload.deal_price.to_s).to eq(updated_deal_price)
    end

    it "updates a deal catalogue flat price" do
      @deal.discount_type = "flat"
      @deal.save
      update_params[:data][:attributes][:deal_price] = 0.0

      patch :update, params: update_params.merge(token: @token, deal_id: @deal.id, id: @deal_catalogue.id)
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['deal_price']).to eq(@deal_catalogue.reload.deal_price.to_f.to_s)
    end

    it "returns errors if deal catalogue update fails" do

      invalid_update_params = {
        data: {
          attributes: {
            catalogue_id: nil
          }
        }
      }

      patch :update, params: invalid_update_params.merge(token: @token, deal_id: @deal.id, id: @deal_catalogue.id)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to include("Catalogue must exist")
    end
  end

  describe "DELETE #destroy" do
    it "destroys a deal catalogue" do
      deal_catalogue = create(:deal_catalogue, deal: @deal, seller: @account)

      delete :destroy, params: { token: @token, deal_id: @deal.id, id: @deal_catalogue.id }

      expect(response).to have_http_status(:ok)
      expect(BxBlockCatalogue::DealCatalogue.find_by(id: @deal_catalogue.id)).to be_nil
      expect(JSON.parse(response.body)["message"]).to include("Deal Catalogue has been removed")
    end
  end
end
