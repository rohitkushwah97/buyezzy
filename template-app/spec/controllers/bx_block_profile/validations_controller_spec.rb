require 'rails_helper' 
require 'simplecov'
RSpec.describe BxBlockProfile::ValidationsController, type: :request do
  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let(:token) { get_token(intern_user) }
  context "GET /validations #index" do
    it "should get all validations" do
      get "/bx_block_profile/validations", headers: {token: token}
      expect(response).to have_http_status(200)
      expect(json_response["data"][0]["email_validation_regexp"]).to eq("[^@]+@\\S+[.]\\S+")
    end
  end
end
