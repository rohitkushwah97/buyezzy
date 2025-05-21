require 'rails_helper' 
require 'simplecov'
RSpec.describe BxBlockProfile::CareerInterestsController, type: :request do

  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let(:intern_user2) { FactoryBot.create(:intern_user, activated: true) }
  let(:industry) { FactoryBot.create(:industry, name: "IT") }
  let(:industry2) { FactoryBot.create(:industry, name: "Electronics") }
  let(:role) { FactoryBot.create(:role, name: "Software Developer", industry_id: industry.id) }
  let(:role2) { FactoryBot.create(:role, name: "App Developer", industry_id: industry.id) }
  let!(:educational_status) { FactoryBot.create(:educational_status, name: "High school", code: "SCH")}
  let!(:school) { FactoryBot.create(:school, name: "school name", educational_status_id: educational_status.id)}
  let!(:school_education) { FactoryBot.create(:school_education, intern_user_id: intern_user2.id) }
  let!(:career_interest) { FactoryBot.create(:career_interest, intern_user_id: intern_user.id)  }
  let!(:career_interest2) { FactoryBot.create(:career_interest, intern_user_id: intern_user.id)  }
  let!(:career_interest3) { FactoryBot.build(:career_interest, intern_user_id: intern_user.id, role_id: role.id, industry_id: industry.id)  }
  let!(:career_interest4) { FactoryBot.create(:career_interest, intern_user_id: intern_user2.id, role_id: role.id, industry_id: industry.id)  }
  let(:token) { get_token(intern_user) }
  let(:token2) { get_token(intern_user2) }
  let(:url) { "/bx_block_profile/career_interests"}
  MESSAGE = 'must exist'

  let(:valid_params) {
    {
      career_interests_attributes: [
        {
          industry_id: industry.id,
          role_id: role.id
        },
        {
          industry_id: industry.id,
          role_id: role2.id
        }
      ]
    }
  }

  let(:invalid_params) {
    {
      career_interests_attributes: [
        {
          industry_id: nil,
          role_id: nil
        }
      ]
    }
  }
  let(:invalid_params2) {
    {
      career_interests_attributes: [
        {
          industry_id: industry.id,
          role_id: role.id
        }
      ]
    }
  }

  context "GET #index" do
    it "should get all career interests" do
      get url, headers: { token: token }
      expect(response).to have_http_status(200)
      expect(json_response["data"][0]["id"].to_i).to eq(career_interest.id)
      expect(json_response["data"][1]["id"].to_i).to eq(career_interest2.id)
    end

    it "should return blank" do
      BxBlockProfile::CareerInterest.destroy_all
      get url, headers: { token: token }
      expect(response).to have_http_status(200)
      expect(json_response["data"]).to eql([])
    end
  end

  context "GET #get_other career interests" do
    it "should get all career interests" do
      get "#{url}/get_other_career_interests", headers: { token: token }
      expect(response).to have_http_status(200)
      res = json_response
      expect(res["data"].last["id"].to_i).to be_present
    end

    it "should return blank" do
      get "#{url}/get_other_career_interests", headers: { token: token }
      expect(response).to have_http_status(200)
      res = json_response
      expect(res["data"].last["attributes"]["roles"][0]["id"]).to be_present
    end
  end

  describe 'POST #create' do
    context 'when creation of career interest successfully' do
      it 'career interest should create successfully' do
        post url, headers: { token: token }, params: valid_params
        res = json_response
        expect(response.status).to eq(201)
        expect(res["message"]).to eql("Career interests added.")
      end
    end

    context 'When validation errors raised' do
      it 'should raised create validation errors' do
        post url, headers:{token: token}, params: invalid_params
        res = json_response
        expect(response.status).to eq(422)
        expect(res["errors"][0][0]["industry"]).to eql(MESSAGE)
        expect(res["errors"][0][1]["role"]).to eql(MESSAGE)
      end

      it 'should raise error while creating when user has school education' do
        post url, headers:{token: token2}, params: valid_params
        res = json_response
        expect(response.status).to eq(401)
        expect(res["message"]).to eql("Career interest cannot be created for High School")
      end

      it 'should raised create validation errors when we create career interests more than 3' do
        career_interest3.save
        post url, headers:{token: token}, params: valid_params
        res = json_response
        expect(response.status).to eq(403)
        expect(res["errors"]["career_interest"]).to eql("You can't create more than 3 career interests")
      end

      it 'should raised create validation errors when industry and role combination is already present for intern user' do
        career_interest2.destroy
        career_interest3.save
        post url, headers:{token: token}, params: invalid_params2
        res = json_response
        expect(response.status).to eq(422)
        expect(res["errors"][0][0]["intern_user"]).to eql("has already been taken industry_role combination.")
      end
    end
  end

  describe "GET /show career interest" do
    it "When show career interest details" do
      career_interest3.save
      get "#{url}/#{career_interest3.id}", headers: {token: token}
      expect(response).to have_http_status(200)
      res = json_response
      expect(res["data"]["id"].to_i).to eql(career_interest3.id)
      expect(res["data"]["attributes"]["industry"]["name"]).to eql(industry.name)
      expect(res["data"]["attributes"]["role"]["name"]).to eql(role.name)
    end

    it "When passing invalid id of career interest" do
      get "#{url}/123456", headers: {token: token}
      res = json_response
      expect(response).to have_http_status(404)
      expect(res["message"]).to eql("Career Interest is not avaialble.")
    end
  end

  describe "DELETE /destroy career interest" do
    it "When delete career interest" do
      delete "#{url}/#{career_interest.id}", headers: {token: token}
      expect(response).to have_http_status(200)
      res = json_response
      expect(res["message"]).to eql("Career Interest deleted.")
    end

    it "When career interest id invalid to delete" do
      delete "#{url}/123456", headers: {token: token}
      res = json_response
      expect(response).to have_http_status(404)
      expect(res["message"]).to eql("Career Interest is not avaialble.")
    end
  end
end