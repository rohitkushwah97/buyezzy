require 'rails_helper'

RSpec.describe BxBlockRequestManagement::RequestInterviewsController, type: :request do
  let!(:business) { create(:business_user, email: 'business@example.com', activated: true) }
  let!(:intern) { create(:intern_user, email: 'intern@example.com', activated: true) }
  let!(:intern2) { create(:intern_user, email: 'intern2@example.com', activated: true) }
  let!(:country) { create(:country) }
  let!(:city) { create(:city, country: country) }
  let!(:industry) { create(:industry) }
  let!(:role) { create(:role) }
  let!(:work_location) { create(:work_location) }
  let!(:work_schedule) { create(:work_schedule) }
  let!(:educational_status) { create(:educational_status) }
  let!(:internship) do
    create(:bx_block_navmenu_internship,
      industry: industry,
      role: role,
      work_location: work_location,
      work_schedule: work_schedule,
      country: country,
      city: city,
      educational_statuses: [educational_status.id],
      business_user: business
    )
  end
  let!(:url) { "/bx_block_request_management/request_interviews" }

  before do
    @business_token = BuilderJsonWebToken.encode(business.id)
    @intern_token = BuilderJsonWebToken.encode(intern.id)
    @intern_token2 = BuilderJsonWebToken.encode(intern2.id)
  end

  describe "POST url" do
    before do
      BxBlockNavmenu::AccountInternship.create!(
        internship_id: internship.id,
        account_id: intern.id,
        status: :pending
      )
    end
    let(:valid_params) do
      {
        request_interview: {
          intern_user_id: intern.id,
          internship_id: internship.id,
          number_of_days: 3
        },
        token: @business_token
      }
    end

    let(:params) do
      {
        request_interview: {
          intern_user_id: 0,
          internship_id: internship.id,
          number_of_days: 3
        },
        token: @business_token
      }
    end

    it "creates a new request interview" do
      post url, params: valid_params

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Interview scheduled successfully")
      account_internship = BxBlockNavmenu::AccountInternship.find_by(
          internship_id: internship.id,
          account_id: intern.id
        )
      expect(account_internship.status).to eq("interview_requested")
    end

    it "returns error when duplicate interview is created" do
      post url, params: valid_params
      expect(response).to have_http_status(:created)

      post url, params: valid_params
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to include("Intern user already has a request for this internship")
    end

  end

  describe "PUT #update (accept interview)" do
    context "when accept an interview for internship by intern" do
      before do
        @interview = BxBlockRequestManagement::RequestInterview.create!(
          internship_id: internship.id,
          intern_user_id: intern.id,
          business_user_id: business.id,
          number_of_days: 3
        )

        @interview2 = BxBlockRequestManagement::RequestInterview.create!(
          internship_id: internship.id,
          intern_user_id: intern2.id,
          business_user_id: business.id,
          status: "rejected",
          number_of_days: 3
        )
      end

      it "successfully accept request" do
        put "/bx_block_request_management/request_interviews/accept_request_interviews", params: { request_interview_id: @interview.id, token: @intern_token }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq("request_interview accepted successfully.")
      end

      it "request not found" do
        put "/bx_block_request_management/request_interviews/accept_request_interviews", params: { request_interview_id: 0, token: @intern_token }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq("You are not authorized to perform this action.")
      end

      it "not found" do
        put "/bx_block_request_management/request_interviews/accept_request_interviews", params: { request_interview_id: @interview.id, token: @business_token }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq("You are not authorized to perform this action.")
      end

      it "request can't accpet" do
        put "/bx_block_request_management/request_interviews/accept_request_interviews", params: { request_interview_id: @interview2.id, token: @intern_token2 }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq("request_interview cannot be accepted.")
      end

    end
  end

  describe "PUT #update (reject interview)" do
    context "when reject an interview for internship by intern" do
      before do
        @interview = BxBlockRequestManagement::RequestInterview.create!(
          internship_id: internship.id,
          intern_user_id: intern.id,
          business_user_id: business.id,
          number_of_days: 3
        )

        @interview2 = BxBlockRequestManagement::RequestInterview.create!(
          internship_id: internship.id,
          intern_user_id: intern2.id,
          business_user_id: business.id,
          status: "accepted",
          number_of_days: 3
        )
      end

      it "successfully reject request" do
        put "/bx_block_request_management/request_interviews/reject_request_interviews", params: { request_interview_id: @interview.id, token: @intern_token }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq("request_interview rejected successfully.")
      end

      it "request not found" do
        put "/bx_block_request_management/request_interviews/reject_request_interviews", params: { request_interview_id: 0, token: @intern_token }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq("You are not authorized to perform this action.")
      end

      it "not authorized user" do
        put "/bx_block_request_management/request_interviews/reject_request_interviews", params: { request_interview_id: @interview.id, token: @business_token }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq("You are not authorized to perform this action.")
      end

      it "request can't reject" do
        put "/bx_block_request_management/request_interviews/reject_request_interviews", params: { request_interview_id: @interview2.id, token: @intern_token2 }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq("request_interview cannot be rejected.")
      end
    end
  end

end
