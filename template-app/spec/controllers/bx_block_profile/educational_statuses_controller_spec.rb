require 'rails_helper' 
require 'simplecov'
RSpec.describe BxBlockProfile::EducationalStatusesController, type: :request do

  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let(:intern_user2) { FactoryBot.create(:intern_user, activated: true) }
  let(:token) { get_token(intern_user) }
  let!(:educational_status) { FactoryBot.create(:educational_status, name: "High school", code: "SCH")}
  let!(:educational_status2) { FactoryBot.create(:educational_status, id: 2, name: "University", code: "UNI")}
  let!(:school) { FactoryBot.create(:school, name: "school name", educational_status_id: educational_status.id)}
  let!(:university) { FactoryBot.create(:university, name: "university name", educational_status_id: educational_status2.id)}
  let(:school_education) { FactoryBot.create(:school_education, intern_user_id: intern_user.id) }
  let(:university_education) { FactoryBot.create(:university_education, university_id: university.id, educational_status_id: educational_status2.id, intern_user_id: intern_user2.id) }
  let(:url) { "/bx_block_profile/educational_statuses"}
  let(:education_url) { "#{url}/get_user_education" }
  let(:nav_url) { "#{url}/get_navigation_detail" }
  let(:school_url) { "/bx_block_profile/educational_statuses/#{educational_status.id}/schools"}
  let(:university_url) { "/bx_block_profile/educational_statuses/#{educational_status2.id}/universities"}
  let(:invalid_school_url) { "/bx_block_profile/educational_statuses/1000/schools"}
  let(:invalid_university_url) { "/bx_block_profile/educational_statuses/10001/universities"}

  # context "GET /educational status #index" do
  #   it "should get all educational statuses" do
  #     get url
  #     expect(response).to have_http_status(200)
  #     expect(json_response["data"][0]["id"].to_i).to eq(educational_status.id)
  #     expect(json_response["data"][1]["id"].to_i).to eq(educational_status2.id)
  #   end

  #   it "should return blank" do
  #     BxBlockProfile::EducationalStatus.destroy_all
  #     get url
  #     expect(response).to have_http_status(200)
  #     expect(json_response["data"]).to eql([])
  #   end
  # end

  context "GET /educational status/get_user_education #get_user_education" do
    it "should get school education" do
      school_education.update(intern_user_id: intern_user.id)
      get education_url, headers: { token: token }
      expect(response).to have_http_status(200)
      res = json_response
      expect(res["data"]["attributes"]["id"].to_i).to eq(school_education.id)
      expect(res["data"]["attributes"]["school"]["name"]).to eq(school_education.school.name)
    end

    it "should get university education" do
      school_education.destroy
      university_education.update(intern_user_id: intern_user.id)
      get education_url, headers: { token: token }
      expect(response).to have_http_status(200)
      res = json_response
      expect(res["data"]["attributes"]["id"].to_i).to eq(university_education.id)
      expect(res["data"]["attributes"]["university"]["name"]).to eq(university_education.university.name)
    end

    it "should get no education" do
      school_education.destroy
      get education_url, headers: { token: token }
      expect(response).to have_http_status(200)
      res = json_response
      expect(res["message"]).to eq("User Education is not available")
    end
  end

  context "GET /schools" do
    it "should get all schools" do
      get school_url
      res = json_response
      expect(response).to have_http_status(200)
      expect(res["data"][0]["attributes"]["id"]).to eq(school.id)
      expect(res["data"][0]["attributes"]["name"]).to eq(school.name)
    end

    it "should raised error" do
      get invalid_school_url
      expect(response).to have_http_status(404)
      expect(json_response["errors"]).to eq(["Record not found"])
    end

  end

  context "GET /universities" do
    it "should get all universities" do
      get university_url
      res = json_response
      expect(response).to have_http_status(200)
      expect(res["data"][0]["attributes"]["id"]).to eq(university.id)
      expect(res["data"][0]["attributes"]["name"]).to eq(university.name)
    end

    it "should return empty array" do
      get invalid_university_url
      expect(response).to have_http_status(200)
      expect(json_response["data"]).to eq([])
    end
  end

  context "GET #get_navigation_detail" do
    it "should get navigation details with full_name" do
      get nav_url, headers: { token: token }
      expect(response).to have_http_status(200)
      res = json_response
      expect(res["data"]["profile"]).to eq(true)
      expect(res["data"]["university_education"]).to eq(false)
      expect(res["data"]["school_education"]).to eq(false)
      expect(res["data"]["career_interests"]).to eq(false)  
    end
  end
end
