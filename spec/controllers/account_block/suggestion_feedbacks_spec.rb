require 'rails_helper'

RSpec.describe AccountBlock::SuggestionFeedbacksController, type: :request do

  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @suggestion_feedback = create(:suggestion_feedback)
    @suggestion_feedbacks_url = "/account_block/suggestion_feedbacks"
  end
  
  let(:valid_attributes) {
    {
      "data": {
        "attributes": {
          "detail_type": "Suggestion",
          "detail": "suggestion detail",
          "first_name": "test",
          "last_name": "user",
          "email": "email@gmail.com"
        }
      }
    }
  }

  let(:invalid_attributes) {
    {
      "data": {
        "attributes": {
          "detail_type": "Suggestion",
        }
      }
    }
  }

  let(:valid_headers) {
    {token: @token}
  }

  describe "GET /index" do
    it "renders a successful response" do
      get @suggestion_feedbacks_url, headers: valid_headers
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get "#{@suggestion_feedbacks_url}/#{@suggestion_feedback.id}", headers: valid_headers
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new SuggestionFeedback" do
        expect {
          post @suggestion_feedbacks_url,
          params: valid_attributes , headers: valid_headers
        }.to change(AccountBlock::SuggestionFeedback, :count).by(1)
      end

      it "renders a JSON response with the new suggestion_feedback" do
        post @suggestion_feedbacks_url,
        params: valid_attributes , headers: valid_headers
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new SuggestionFeedback" do
        expect {
          post @suggestion_feedbacks_url,
          params: invalid_attributes ,headers: valid_headers
        }.to change(AccountBlock::SuggestionFeedback, :count).by(0)
      end

      it "renders a JSON response with errors for the new suggestion_feedback" do
        post @suggestion_feedbacks_url,
        params: invalid_attributes ,headers: valid_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # describe "PATCH /update" do
  #   context "with valid parameters" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested suggestion_feedback" do
  #       suggestion_feedback = SuggestionFeedback.create! valid_attributes
  #       patch suggestion_feedback_url(suggestion_feedback),
  #       params: { suggestion_feedback: new_attributes }, headers: valid_headers, as: :json
  #       suggestion_feedback.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "renders a JSON response with the suggestion_feedback" do
  #       suggestion_feedback = SuggestionFeedback.create! valid_attributes
  #       patch suggestion_feedback_url(suggestion_feedback),
  #       params: { suggestion_feedback: new_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:ok)
  #       expect(response.content_type).to match(a_string_including("application/json"))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "renders a JSON response with errors for the suggestion_feedback" do
  #       suggestion_feedback = SuggestionFeedback.create! valid_attributes
  #       patch suggestion_feedback_url(suggestion_feedback),
  #       params: { suggestion_feedback: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to match(a_string_including("application/json"))
  #     end
  #   end
  # end

  describe "DELETE /destroy" do
    it "destroys the requested suggestion_feedback" do
      expect {
        delete "#{@suggestion_feedbacks_url}/#{@suggestion_feedback.id}", headers: valid_headers
      }.to change(AccountBlock::SuggestionFeedback, :count).by(-1)
      body = JSON.parse(response.body)
      expect(body['meta']['message']).to eq('Suggestion or Feedback Removed')
    end
  end
end
