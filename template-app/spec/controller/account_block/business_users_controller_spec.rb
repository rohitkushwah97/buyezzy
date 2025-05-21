require 'rails_helper' 
require 'simplecov'
RSpec.describe AccountBlock::BusinessUsersController, type: :request do
  let(:industry) { FactoryBot.create(:industry)}
  let(:country) { FactoryBot.create(:country)}
  let(:city) { FactoryBot.create(:city, country_id: country.id)}
	let(:business_user) { FactoryBot.create(:business_user, activated: true) }
	let(:token) { get_token(business_user) }
	let(:url) { "/account_block/business_users"}
	let(:valid_params) do
		{
	    "data": {
	      "attributes": {
	        "email": "shanskar@yopmail.com",
	        "password": "Password@12"
	      }
	  	}
		}	
	end

  let(:valid_params2) do
    {
      "data": {
        "attributes": {
          "email": business_user.email,
          "password": "Password@123"
        }
      }
    } 
  end

  let(:invalid_params) do
    {
      "data": {
        "attributes": {
          "email": nil,
          "password": "Password@1234"
        }
      }
    } 
  end

  let(:update_params) do
    {
      email: "test123@yopmail.com",
      company_detail_attributes:{ id: business_user.company_detail.id, company_name: "builder.ai",
                                  industry_id: industry.id, website_link: "www.yono.com", contact_number: "917697063811",
                                  country_id: country.id, city_id: city.id, address: "vijay nagar indore",
                                  company_description: "company description", photo: fixture_file_upload(Rails.root.join('spec/fixtures/images/part_time.png'), 'image/png')
                                }
    } 
  end

  let(:invalid_update_params) do
    {
      email: "test@yopmail.com",
      company_detail_attributes: {id: business_user.company_detail.id, company_name: "builder.ai"}
    } 
  end

  context "GET#Index" do
    it "should give list of business users" do
      get "#{url}/list", headers: { token: token }
      res = json_response
      expect(response).to have_http_status(200)
      expect(res["data"][0]["attributes"]["activated"]).to eq(false)
    end
  end

  context "POST#create" do
    it "should signup business user" do
      post url, params: valid_params
      res = json_response
      expect(response).to have_http_status(201)
      expect(res['data']['attributes']['email']).to eq('shanskar@yopmail.com')
    end

    it "should raise validation" do
      post url, params: valid_params2
      res = json_response
      expect(response).to have_http_status(422)
      expect(res["errors"][0]["email"]).to eq("The email address is already taken. Please try another.")
    end

    it "should raise validation error" do
      post url, params: invalid_params
      res = json_response
      expect(response).to have_http_status(422)
      expect(res["errors"][0]["email"]).to eq("can't be blank")
      expect(res["errors"][1]["email"]).to eq("is invalid")
    end
  end

  context "GET#Show" do
    it "should return business user" do
      get url, headers: { token: token }
      res = json_response
      expect(response).to have_http_status(200)
      expect(res["data"]["id"].to_i).to eq(business_user.id)
    end
  end

  context "PUT#UPDATE" do
    it "should update successfully" do
      put url, headers: { token: token }, params: update_params
      res = json_response
      expect(response).to have_http_status(200)
      expect(res["data"]["attributes"]["email"]).to eql("test123@yopmail.com")
    end

    it "should raise validation error while update business user" do
      put url, headers: { token: token }, params: invalid_update_params
      res = json_response
      expect(response).to have_http_status(422)
      expect(res["errors"][0]["company_detail.address"]).to eql("can't be blank")
      expect(res["errors"][3]["company_detail.industry"]).to eql("must exist")
    end
  end

  context "DELETE#Destroy" do
    it "should delete business user" do
      delete url, headers: { token: token }
      res = json_response
      expect(response).to have_http_status(200)
      expect(res["message"]).to eq("Business User deleted.")
    end
  end

  describe 'GET #list_cities' do
    let!(:country) { create(:country) }
    let!(:city1) { create(:city, country: country) } 
    let!(:city2) { create(:city, country: country) }

    context 'when the country exists' do
      it 'returns a list of cities for the given country' do
        get "#{url}/list_cities", headers: { token: token }, params: { country_id: country.id }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['cities']).to match_array([
          { 'id' => city1.id, 'name' => city1.name },
          { 'id' => city2.id, 'name' => city2.name }
        ])
      end
    end

    context 'when the country does not exist' do
      it 'returns an empty array with a 404 status' do
        get "#{url}/list_cities", headers: { token: token }, params: { country_id: 9999 }
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response).to eq([])
      end
    end

    context 'when country_id is not provided' do
      it 'returns an empty array with a 404 status' do
        get "#{url}/list_cities", headers: { token: token }
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response).to eq([])
      end
    end
  end
end