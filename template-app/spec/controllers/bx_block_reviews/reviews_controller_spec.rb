require 'rails_helper'

RSpec.describe BxBlockReviews::ReviewsController, type: :controller do
  let!(:business) { create(:business_user, email: 'business@example.com', activated: true) }
  let!(:intern) { create(:intern_user, email: 'intern@example.com', activated: true) }

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

  before do
    @business_token = BuilderJsonWebToken.encode(business.id)
    @intern_token = BuilderJsonWebToken.encode(intern.id)
  end

  describe "POST #create (Creating Reviews)" do
    context "when creating an internship review" do
      let(:internship_review_params) do
        {
          review: {
            reviews_type: "internship",
            title: "Great Internship",
            internship_id: internship.id,
            reviewer_id: intern.id,
            description: "This internship was very helpful."
          },
          token: @intern_token
        }
      end

      let(:internship_review_params2) do
        {
          review: {
            reviews_type: "abc",
            title: "Great Internship",
            internship_id: internship.id,
            reviewer_id: intern.id,
            description: "This very helpful."
          },
          token: @intern_token
        }
      end

      it "successfully creates an internship review" do
        post :create, params: internship_review_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['data']['type']).to eq("review")
      end

      it "fails when Invalid reviews_type" do
        post :create, params: internship_review_params2
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq("Invalid reviews_type")
      end

      it "fails when internship_id is missing" do
        internship_review_params[:review].delete(:internship_id)
        post :create, params: internship_review_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq("internship is not present with same id")
      end

      it "fails when a duplicate internship review is created" do
        post :create, params: internship_review_params
        post :create, params: internship_review_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq("Internship review already exists")
      end
    end

    context "when creating a chatbox review" do
      # let(:chatbox_review_params) do
      #   {
      #     review: {
      #       reviews_type: "chatbox",
      #       title: "Chatbox Feedback",
      #       description: "Very useful chatbox",
      #       prompt_manager_id: 1,
      #       rating: 5,
      #       version_id: 2
      #     },
      #     token: @intern_token
      #   }
      # end

      let(:chatbox_review_params2) do
        {
          review: {
            reviews_type: "chatbox",
            title: "Chatbox Feedback",
            description: "Very useful chatbox",
            internship_id: internship.id,
            rating: 5,
            # version_id: 2
          },
          token: @intern_token
        }
      end

      # it "successfully creates a chatbox review" do
      #   post :create, params: chatbox_review_params
      #   expect(response).to have_http_status(:created)
      #   expect(JSON.parse(response.body)['data']['type']).to eq("review")
      # end

      it "fails when required fields are missing" do
        post :create, params: chatbox_review_params2
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to include("Missing required fields: version_id")
      end
    end

    context "when creating a business-to-intern feedback review" do
      let(:business_feedback_params) do
        {
          review: {
            reviews_type: "business_feedback",
            internship_id: internship.id,
            reviewer_id: business.id,
            description: "Good work by the intern."
          },
          token: @business_token
        }
      end

      it "successfully creates a business feedback review" do
        post :create, params: business_feedback_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['data']['type']).to eq("review")
      end

      it "fails when internship_id is missing" do
        business_feedback_params[:review].delete(:internship_id)
        post :create, params: business_feedback_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq("internship is not present with same id")
      end

      it "fails when a non-business user tries to create business feedback" do
        business_feedback_params[:token] = @intern_token # Change token to intern's
        post :create, params: business_feedback_params
        expect(response).to have_http_status(:forbidden)
        expect(JSON.parse(response.body)['error']).to eq("Only business users can give business-to-intern feedback")
      end
    end
  end

  describe "GET #show_feedback (Fetching Reviews)" do
    before do
      @review = BxBlockReviews::Review.create!(
        internship_id: internship.id,
        reviewer_id: business.id,
        description: "Sample review description",
        account_id: intern.id,
        reviews_type: "internship"
      )
    end

    it "returns review when it exists" do
      get :show_feedback, params: { reviews_type: "internship", internship_id: internship.id, token: @business_token }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].first['type']).to eq("review")
    end

    it "returns error when review is not found" do
      get :show_feedback, params: { reviews_type: "internship", internship_id: 0, token: @intern_token }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq("No reviews found")
    end
  end
end
