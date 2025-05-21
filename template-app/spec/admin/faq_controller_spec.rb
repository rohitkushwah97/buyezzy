require 'rails_helper'
require 'spec_helper'

include Warden::Test::Helpers

RSpec.describe Admin::FaqsController, type: :controller do
  render_views

  SAMPLE_QUESTION = 'Sample Question'.freeze # Define a constant for "Sample Question"

  let!(:admin) { FactoryBot.create(:admin) }
  let!(:faq) { FactoryBot.create(:faq, question: SAMPLE_QUESTION, answer: 'Sample Answer', created_for: 'Business user') }

  before(:each) do
    sign_in admin
  end

  describe 'GET #index' do
    it 'displays all FAQs' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include(SAMPLE_QUESTION) # Use the constant here
      expect(response.body).to include('Created For')
    end
  end

  describe 'GET #show' do
    it 'displays the FAQ details' do
      get :show, params: { id: faq.id }
      expect(response).to have_http_status(:success)
      expect(response.body).to include(faq.question)
      expect(response.body).to include(faq.answer)
      expect(response.body).to include(faq.created_for)
    end
  end

  describe 'GET #new' do
    it 'renders the new FAQ form' do
      get :new
      # expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new FAQ' do
        expect {
          post :create, params: { faq: { question: 'New Question', answer: 'New Answer', created_for: 'Intern user' } }
        }.to change(BxBlockHelpCentre::Faq, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new FAQ and renders the new template' do
        expect {
          post :create, params: { faq: { question: '', answer: '', created_for: '' } }
        }.not_to change(BxBlockHelpCentre::Faq, :count)

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit FAQ form' do
      get :edit, params: { id: faq.id }
      # expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the FAQ' do
        patch :update, params: { id: faq.id, faq: { question: 'Updated Question', answer: 'Updated Answer', created_for: 'Business user' } }
        faq.reload

        expect(faq.question).to eq('Updated Question')
        expect(faq.answer).to eq('Updated Answer')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the FAQ and renders the edit template' do
        patch :update, params: { id: faq.id, faq: { question: '', answer: '', created_for: '' } }
        faq.reload

        expect(faq.question).to eq(SAMPLE_QUESTION) # Use the constant here
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the FAQ' do
      faq
      expect {
        delete :destroy, params: { id: faq.id }
      }.to change(BxBlockHelpCentre::Faq, :count).by(-1)

      expect(response).to redirect_to(admin_faqs_path)
      expect(flash[:notice]).to match(/successfully destroyed/)
    end
  end
end
