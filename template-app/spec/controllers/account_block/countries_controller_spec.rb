require 'rails_helper' 
require 'simplecov'
RSpec.describe AccountBlock::CountriesController, type: :request do

	let!(:country) { FactoryBot.create(:country) }
	let!(:city) { FactoryBot.create(:city, country_id: country.id)}
	let!(:country2) { FactoryBot.create(:country, name: "Dubai") }
	let!(:city2) { FactoryBot.create(:city, country_id: country2.id)}
	let(:url) { "/account_block/countries"}

	context "GET /countries #show" do
		it "should get all cities" do
      get "#{url}/#{country.id}"
      res = json_response
      expect(response).to have_http_status(200)
      expect(res["data"][0]["attributes"]["id"]).to eq(city.id)
      expect(res["data"][0]["attributes"]["name"]).to eq(city.name)
    end

    it "should raised error" do
      get "#{url}/1000"
      expect(response).to have_http_status(404)
      expect(json_response["errors"]).to eq(["Record not found"])
    end

	end
end