require 'rails_helper' 
require 'simplecov'
RSpec.describe BxBlockTermsAndConditions::TermsAndConditionsController, type: :request do
  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let(:business_user) { FactoryBot.create(:business_user, activated: true) }
  let(:intern_token) { get_token(intern_user) }
  let(:business_token) { get_token(business_user) }
  let!(:term) { FactoryBot.create(:term_and_condition) }
  let!(:policy) { FactoryBot.create(:privacy_policy) }
  let(:url) {"/bx_block_terms_and_conditions/terms_and_conditions"}
  let(:url2) {"/bx_block_terms_and_conditions/policies"}

  describe "GET /Index" do
    it "should return success response of index" do
      get url, params: { type: "intern" }
      res = json_response
      expect(response).to have_http_status(200)
      expect(res["data"][0]["id"].to_i).to eql(term.id)
      expect(res["data"][0]["description"]).to eql(term.description)
    end

    it "should return success response of index" do
      get url, params: { type: "business" }
      res = json_response
      expect(response).to have_http_status(404)
      expect(res["message"]).to eql('Records are not available.')
    end
  end

  describe "GET /get privacy policies" do
    it "should return success response of policy" do
      get url2, headers: { token: intern_token }
      res = json_response
      expect(response).to have_http_status(200)
      expect(res["data"][0]["id"].to_i).to eql(policy.id)
      expect(res["data"][0]["description"]).to eql(policy.description)
    end

    it "should return success response of policies" do
      get url2, headers: { token: business_token }
      res = json_response
      expect(response).to have_http_status(404)
      expect(res["message"]).to eql('Policy not found.')
    end
  end

end
