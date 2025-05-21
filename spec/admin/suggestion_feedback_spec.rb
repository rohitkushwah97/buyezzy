require 'rails_helper'

RSpec.describe Admin::SuggestionFeedbacksController, type: :controller do
  render_views
  let(:admin_user) { create(:admin_user) }

  before do
    sign_in admin_user
    @suggestion_feedback = create(:suggestion_feedback)
  end

  describe "GET /admin/suggestion_feedbacks" do
    it "displays the suggestion feedbacks index page" do

      get :index

      expect(response).to have_http_status(200)
      expect(response.body).to include(@suggestion_feedback.email)
      expect(response.body).to include(@suggestion_feedback.first_name)
      expect(response.body).to include(@suggestion_feedback.last_name)
      expect(response.body).to include(@suggestion_feedback.detail_type)
    end
  end

  describe "GET /admin/suggestion_feedbacks/:id" do
    it "displays the suggestion feedback show page" do
      

      get :show , params: { id: @suggestion_feedback.id }

      expect(response).to have_http_status(200)
      expect(response.body).to include(@suggestion_feedback.email)
      expect(response.body).to include(@suggestion_feedback.first_name)
      expect(response.body).to include(@suggestion_feedback.last_name)
      expect(response.body).to include(@suggestion_feedback.detail_type)
    end
  end

  # describe "POST /admin/suggestion_feedbacks" do
  #   it "creates a new suggestion feedback" do

  #     expect {
  #       post :create, params: { suggestion_feedback: {email: "test@gmail.com",first_name: "test",last_name: "user",detail_type: "FeedBack", account_id: @suggestion_feedback.account_id } }
  #     }.to change(AccountBlock::SuggestionFeedback, :count).by(1)

  #     expect(response).to have_http_status(302) 
  #     expect(response).to redirect_to(admin_suggestion_feedback_path(AccountBlock::SuggestionFeedback.last))
  #   end
  # end

  describe 'GET new' do

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

  end
end
