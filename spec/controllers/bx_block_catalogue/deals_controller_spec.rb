require 'rails_helper'

RSpec.describe BxBlockCatalogue::DealsController, type: :controller do
  before do
    @account = FactoryBot.create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @deal = create(:deal,status: true)
  end

  describe "GET #index" do
    it "returns a list of active deals" do
      get :index, params: { token: @token }

      expect(response).to have_http_status(:ok)
      # expect(JSON.parse(response.body)["data"].size).to eq(BxBlockCatalogue::Deal.active_deals.count)
    end
  end

  describe "GET #show" do
    context "when deal exists" do
      it "returns the deal" do
        get :show, params: { token: @token, id: @deal.id }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["id"]).to eq(@deal.id.to_s)
      end
    end

    context "when deal does not exist" do
      it "returns a not found message" do
        non_existent_id = 999

        get :show, params: { token: @token, id: non_existent_id }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["message"]).to eq("Deal not available")
      end
    end
  end
end
