require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  render_views

  it 'redirects to login' do
    get :index

    expect(response).to redirect_to(new_admin_user_session_path)
  end

  context 'when logged in as admin' do
    let(:admin) { create(:admin_user) }

    before { sign_in(admin) }

    it 'renders page' do
      get :index

      expect(response).to render_template(:index)
      expect(response.body).to include('Welcome to Active Admin. This is the default dashboard page')
    end
  end
end