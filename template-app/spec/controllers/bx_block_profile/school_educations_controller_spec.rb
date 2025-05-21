require 'rails_helper' 
require 'simplecov'
RSpec.describe BxBlockProfile::SchoolEducationsController, type: :request do

  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let!(:educational_status) { FactoryBot.create(:educational_status, name: "School", code: "SCH") }
  let!(:school) { FactoryBot.create(:school, name: "CPS", educational_status_id: educational_status.id) }
  let!(:academic_level) { FactoryBot.create(:academic_level) }
  let!(:school_education) { FactoryBot.create(:school_education, intern_user_id: intern_user.id, educational_status_id: educational_status.id, school_id: school.id, academic_level_id: academic_level.id) }
  let(:token) { get_token(intern_user) }
  let(:url) { "/bx_block_profile/school_educations"}
  MESSAGE = 'must exist'

  let(:valid_params) {
    {
      educational_status_id: educational_status.id,
      school_id: school.id,
      academic_level_id: academic_level.id,
      academic_achievement: "topped in JEE",
      extracurricular_activity: "sleep",
      soft_skill: "public speaking",
      interest: "tech, writing",
      hobby: "cricket, music"
    }
  }

  let(:update_params) {
    {
      academic_achievement: "NEET topper",
      extracurricular_activity: "dance",
    }
  }

  let(:invalid_update_params) {
    {
      "educational_status_id": nil,
      "school_id": nil,
      "school_name": nil,
      "academic_level_id": nil,
      "academic_achievement": nil,
      "extracurricular_activity": nil,
      "soft_skill": nil,
      "interest": nil,
      "hobby": nil
    }
  }

  describe 'POST #create' do
    context 'when creation of school education successfully' do
      it 'school education  should create successfully' do
        post url, headers:{token: token}, params: valid_params
        res = json_response
        expect(response.status).to eq(201)
        expect(res["data"]["attributes"]["academic_achievement"]).to eql("topped in JEE")
        expect(res["data"]["attributes"]["interest"]).to eql('tech, writing')
        expect(res["data"]["attributes"]["educational_status"]["name"]).to eql(educational_status.name)
        expect(res["data"]["attributes"]["school"]["name"]).to eql(school.name)
        expect(res["data"]["attributes"]["academic_level"]["id"]).to eql(academic_level.id)
      end
    end

    context 'When validation errors raised' do
      it 'should raised create validation errors' do
        post url, headers:{token: token}, params: invalid_update_params
        res = json_response
        expect(response.status).to eq(422)
        expect(res["errors"][0]["academic_level"]).to eql(MESSAGE)
        expect(res["errors"][1]["educational_status"]).to eql(MESSAGE)
        expect(res["errors"][2]["school"]).to eql(MESSAGE)
      end
    end
  end

  describe 'PUT #update' do
    context 'when updation of school education' do
      it 'school education udate successfully' do
         put url, headers: {token: token}, params: update_params
         res = json_response
         expect(response.status).to eq(200)
         expect(res["data"]["attributes"]["academic_achievement"]).to eql("NEET topper")
         expect(res["data"]["attributes"]["extracurricular_activity"]).to eql('dance')
      end

      it 'should raised update validation errors' do
        put url, headers: {token: token}, params: invalid_update_params
        res = json_response
        expect(response.status).to eq(422)
        expect(res["errors"][0]["academic_level"]).to eql(MESSAGE)
        expect(res["errors"][1]["educational_status"]).to eql(MESSAGE)
        expect(res["errors"][2]["school"]).to eql(MESSAGE)
      end

    end
  end

  describe "GET /show school education" do
    it "When show school education details" do
      get url, headers: {token: token}
      expect(response).to have_http_status(200)
      res = json_response
      expect(res["data"]["id"].to_i).to eql(school_education.id)
      expect(res["data"]["attributes"]["educational_status"]["name"]).to eql(educational_status.name)
      expect(res["data"]["attributes"]["school"]["name"]).to eql(school.name)
      expect(res["data"]["attributes"]["academic_level"]["id"]).to eql(academic_level.id)
    end

    it "When deal id invalid to show" do
      BxBlockProfile::SchoolEducation.destroy_all
      get url, headers: {token: token}
      res = json_response
      expect(response).to have_http_status(404)
      expect(res["message"]).to eql("School education is not avaialble.")
    end
  end

end