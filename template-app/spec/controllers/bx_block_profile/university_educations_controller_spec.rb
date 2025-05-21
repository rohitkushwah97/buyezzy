require 'rails_helper' 
require 'simplecov'
RSpec.describe BxBlockProfile::UniversityEducationsController, type: :request do
  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let!(:educational_status) { FactoryBot.create(:educational_status, name: "University", code: "UNI")}
  let!(:university) { FactoryBot.create(:university, name: "university name", educational_status_id: educational_status.id)}
  let!(:university_education) { FactoryBot.create(:university_education, intern_user_id: intern_user.id, educational_status_id: educational_status.id, university_id: university.id, university_name: "DU", specialisation: "MCA", graduation_year: 2025)}
  let(:token) { get_token(intern_user) }
  let(:url) { "/bx_block_profile/university_educations"}
  MESSAGE = 'must exist'

  let(:valid_params) {
    {
      "educational_status_id": nil,
      "university_id": nil,
      "university_name": "VIT",
      "specialisation": "BBA",
      "graduation_year": 2024
    }
  }

  let(:update_params) {
    {
      "specialisation": "M.tech",
      "graduation_year": 2028
    }
  }

  let(:invalid_update_params) {
    {
      "educational_status_id": nil,
      "university_id": nil,
    }
  }

  describe 'POST #create' do
    context 'when creation of unversity education successfully' do
      it 'unversity education  should create successfully' do
        post url, headers:{token: token}, params: 
        {
          "educational_status_id": educational_status.id,
          "university_id": university.id,
          "university_name": "VIT",
          "specialisation": "B.tech",
          "graduation_year": 2024
        }
        res = json_response
        expect(response.status).to eq(201)
        expect(res["data"]["attributes"]["specialisation"]).to eql("B.tech")
        expect(res["data"]["attributes"]["graduation_year"]).to eql(2024)
        expect(res["data"]["attributes"]["educational_status"]["name"]).to eql(educational_status.name)
        expect(res["data"]["attributes"]["university"]["name"]).to eql(university.name)
      end
    end

    context 'When validation errors raised' do
      it 'should raised create validation errors' do
        post url, headers:{token: token}, params: valid_params
        res = json_response
        expect(response.status).to eq(422)
        expect(res["errors"][0]["educational_status"]).to eql(MESSAGE)
        expect(res["errors"][1]["university"]).to eql(MESSAGE)
      end
    end
  end

  describe 'PUT #update' do
    context 'when updation of university education' do
      it 'university education udate successfully' do
        put url, headers: {token: token}, params: update_params
        res = json_response
        expect(response.status).to eq(200)
        expect(res["data"]["attributes"]["specialisation"]).to eql("M.tech")
        expect(res["data"]["attributes"]["graduation_year"]).to eql(2028)
        expect(res["data"]["attributes"]["educational_status"]["name"]).to eql(educational_status.name)
        expect(res["data"]["attributes"]["university"]["name"]).to eql(university.name)
      end

      it 'should raised update validation errors' do
        put url, headers: {token: token}, params: invalid_update_params
        res = json_response
        expect(response.status).to eq(422)
        expect(res["errors"][0]["educational_status"]).to eql(MESSAGE)
        expect(res["errors"][1]["university"]).to eql(MESSAGE)
      end

    end
  end

  describe "GET /show university education" do
    it "When show university education details" do
      get url, headers: {token: token}
      res = json_response
      expect(response).to have_http_status(200)
      expect(json_response["data"]["id"].to_i).to eql(university_education.id)
      expect(res["data"]["attributes"]["educational_status"]["name"]).to eql(educational_status.name)
      expect(res["data"]["attributes"]["university"]["name"]).to eql(university.name)
    end

    it "When deal id invalid to show" do
      BxBlockProfile::UniversityEducation.destroy_all
      get url, headers: {token: token}
      res = json_response
      expect(response).to have_http_status(404)
      expect(res["message"]).to eql("Unversity education is not avaialble.")
    end
  end

end