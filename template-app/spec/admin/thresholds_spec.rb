require 'rails_helper'

RSpec.describe Admin::ThresholdsController, type: :controller do
  render_views

  before(:each) do
    admin = FactoryBot.create(:admin)
    sign_in admin
  end
  describe 'Issue Type #index' do
    context 'Get Index' do
      it 'should have http status success for index' do
        get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
        expect(response.message).to eq('OK')

      end
    end
  end
end