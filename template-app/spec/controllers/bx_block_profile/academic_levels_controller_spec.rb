require 'rails_helper' 
require 'simplecov'
RSpec.describe BxBlockProfile::AcademicLevelsController, type: :request do

  let!(:academic_level) { FactoryBot.create(:academic_level, name: "9th Standard")}
  let!(:academic_level2) { FactoryBot.create(:academic_level, name: "11th Standard")}
  let(:url) { "/bx_block_profile/academic_levels"}


  context "GET /academic_levels #index" do
    it "should get all academic levels" do
      get url
      expect(response).to have_http_status(200)
      expect(json_response["data"][0]["id"].to_i).to eq(academic_level.id)
      expect(json_response["data"][1]["id"].to_i).to eq(academic_level2.id)
    end

    it "should return blank" do
      BxBlockProfile::AcademicLevel.destroy_all
      get url
      expect(response).to have_http_status(200)
      expect(json_response["data"]).to eql([])
    end
  end
end