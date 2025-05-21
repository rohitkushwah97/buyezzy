require 'rails_helper'

RSpec.describe BxBlockProfile::CompanyDetailsController, type: :controller do
  before do
  @business_user = FactoryBot.create(:business_user)
  @industry = FactoryBot.create(:industry)
  @country = FactoryBot.create(:country)
  @city = FactoryBot.create(:city)
  @token = BuilderJsonWebToken::JsonWebToken.encode(@business_user.id)
  @company = FactoryBot.create(:company_detail, business_user: @business_user)
  @intern_user = FactoryBot.create(:intern_user, activated: true)

  end
  
  let(:valid_attributes) {
    {
      company_name: "Tech Corp",
      industry_id: @industry.id,
      website_link: "https://techcorp.com",
      country_id: @country.id,
      city_id: @city.id,
      contact_number: "+971555555555",
      address: "123 Tech Street",
      company_description: "We are a tech company."
    }
  }

  let(:invalid_attributes) {
    {
      company_name: "",
      industry_id: nil,
      website_link: nil,
      contact_number: nil,
      country_id: nil,
      city_id: nil,
      address: nil,
      company_description: ""
    }
  }

  describe 'GET #show' do
    context 'when the company_detail exists' do
      it 'returns the company_detail' do
        get :show, params: { token: @token }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data']).to be_present
      end
    end
  end

  describe "PUT #update" do
    before do
      company_detail = FactoryBot.create(:company_detail, business_user: @business_user)
      put :update, params: { token: @token, company_detail: valid_attributes }
    end
    context "with valid parameters" do
      it "returns a success response" do
        res = json_response
        expect(response).to have_http_status(:ok)
        expect(res["data"]["country_code"]).to eql(971)
        expect(res["data"]["phone_number"]).to eql(555555555)
        expect(JSON.parse(response.body)["message"]).to eq("Profile updated successfully")
      end
    end

    context "with invalid parameters" do
      it "returns an unprocessable entity response" do
        put :update, params: { token: @token, company_detail: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to be_present
      end
    end
  end

  describe "GET #intern_user_profile_details with followers followings count" do
    it "returns intern_user profile details" do
      get :intern_user_profile_details, params: { token: @token, intern_user_id: @intern_user.id}
      expect(response).to have_http_status 200
      expect(json_response['data']['id'].to_i).to eq(@intern_user.id)
    end
  end
end
