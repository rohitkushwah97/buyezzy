require 'rails_helper'

RSpec.describe BxBlockSurveys::MakeOffersController, type: :controller do
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
      deadline_date: Date.today + 7.days,
      role: role,
      work_location: work_location,
      work_schedule: work_schedule,
      country: country,
      city: city,
      educational_statuses: [educational_status.id],
      business_user: business
    )
  end

  before do
    @business_token = BuilderJsonWebToken.encode(business.id)
    @intern_token = BuilderJsonWebToken.encode(intern.id)
    @intern_token2 = BuilderJsonWebToken.encode(intern2.id)
  end

  describe "POST #create (Creating offer)" do
    context "when AccountInternship exists" do
      before do
        BxBlockNavmenu::AccountInternship.create!(
          internship_id: internship.id,
          account_id: intern.id,
          status: :offered
        )
      end

      let(:offer_params) do
        {
          make_offer: {
            internship_id: internship.id,
            intern_user_id: intern.id
          },
          token: @business_token
        }
      end

      it "creates offer and updates AccountInternship to offered" do
        post :create, params: offer_params

        account_internship = BxBlockNavmenu::AccountInternship.find_by(
          internship_id: internship.id,
          account_id: intern.id
        )
        expect(account_internship.status).to eq("offered")
      end

      it 'returns error when internship already started' do
        internship.update(start_date: Date.yesterday)
        post :create, params: offer_params
        expect(JSON.parse(response.body)['error']).to eq('Cannot send new offers after the start date of internship.')
      end
    end
  end

  describe "PUT #update (accept offer)" do
    context "when accept an offer for internship by intern" do
      before do
        @offer = BxBlockSurveys::MakeOffer.create!(
          internship_id: internship.id,
          intern_user_id: intern.id,
          business_user_id: business.id,
          number_of_days: 3
        )

        @offer2 = BxBlockSurveys::MakeOffer.create!(
          internship_id: internship.id,
          intern_user_id: intern2.id,
          business_user_id: business.id,
          offer_status: "rejected",
          number_of_days: 3
        )
      end

      let(:offer_params) do
        {
          offer_id: @offer.id,
          token: @intern_token
        }
      end

      let(:offer_params2) do
        {
          offer_id: 0,
          token: @intern_token
        }
      end

      let(:offer_params3) do
        {
          offer_id: @offer.id,
          token: @business_token
        }
      end

      let(:offer_params4) do
        {
          offer_id: @offer2.id,
          token: @intern_token2
        }
      end

      it "successfully accept offer" do
        put :accept, params: offer_params
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq("Offer accepted successfully.")
      end

      it "offer not found" do
        put :accept, params: offer_params2
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq("You are not authorized to perform this action.")
      end

      it "not found" do
        put :accept, params: offer_params3
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq("You are not authorized to perform this action.")
      end

      it "offer can  accpet" do
        put :accept, params: offer_params4
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq("Offer cannot be accepted.")
      end
    end
  end

  describe "PUT #update (reject offer)" do
    context "when reject an offer for internship by intern" do
      before do
        @offer = BxBlockSurveys::MakeOffer.create!(
          internship_id: internship.id,
          intern_user_id: intern.id,
          business_user_id: business.id,
          number_of_days: 3
        )

        @offer2 = BxBlockSurveys::MakeOffer.create!(
          internship_id: internship.id,
          intern_user_id: intern2.id,
          business_user_id: business.id,
          offer_status: "accepted",
          number_of_days: 3
        )

      end

      let(:offer_params) do
        {
          offer_id: @offer.id,
          token: @intern_token
        }
      end

      let(:offer_params2) do
        {
          offer_id: @offer2.id,
          token: @intern_token2
        }
      end

      it "successfully reject offer" do
        put :reject, params: offer_params
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq("Offer rejected successfully.")
      end

      it "reject can not done for offer" do
        put :reject, params: offer_params2
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq("Offer cannot be rejected.")
      end
    end
  end
end
