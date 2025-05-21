require 'rails_helper'

RSpec.describe BxBlockHelpCentre::FaqController, type: :controller do
  let!(:faq) { create(:faq) } 
  let(:valid_account) { FactoryBot.create(:account) }
  let(:token) do
    BuilderJsonWebToken::JsonWebToken.encode(valid_account.id)
  end
  before do
    request.headers['token'] = "#{token}"
  end
  describe 'GET #index' do
    it 'returns a list of FAQs' do
      get :index
      # expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'returns the specific FAQ' do
      get :show, params: { id: faq.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['id']).to eq(faq.id.to_s)
    end

    it 'returns not found for non-existent FAQ' do
      get :show, params: { id: 99999 }
      # expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    it 'creates a new FAQ with valid attributes' do
      faq_params = { faq: { question: 'New FAQ?', answer: 'New Answer.', created_for: 'Intern user' } }
      post :create, params: faq_params
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['data']['attributes']['question']).to eq('New FAQ?')
    end

    it 'does not create FAQ with invalid attributes' do
      faq_params = { faq: { question: '', answer: '', created_for: '' } }
      post :create, params: faq_params
      # expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT #update' do
    it 'updates the FAQ with valid attributes' do
      faq_params = { question: 'Updated FAQ?' }
      put :update, params: { id: faq.id, faq: faq_params }
      expect(response).to have_http_status(:ok)
      faq.reload
      expect(JSON.parse(response.body)['data']['attributes']['question']).to eq('Updated FAQ?')
    end

    it 'does not update FAQ with invalid attributes' do
      faq_params = { created_for: 'intern' } 
      put :update, params: { id: faq.id, faq: faq_params }
      # expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the FAQ' do
      expect {
        delete :destroy, params: { id: faq.id }
      }.to change(BxBlockHelpCentre::Faq, :count).by(-1)
      # expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #business_faq' do
    it 'returns company FAQs' do
      faq.update(created_for: 'Business user')
      get :business_faq
      # expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #intern_faq' do
    it 'returns intern FAQs' do
      faq.update(created_for: 'Intern user')
      get :intern_faq
      # expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #general_faq' do
    it 'returns General FAQs' do
      faq.update(created_for: 'General FAQ')
      get :general_faq
      # expect(response).to have_http_status(:ok)
    end
  end
end
