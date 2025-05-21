require 'rails_helper'

RSpec.describe Admin::AdminUsersController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'with filters' do
      it 'filters by email' do
        get :index, params: { q: { email_cont: @admin.email } }
        expect(response).to render_template(:index)
      end

       it 'filters by created_at' do
        user1 = FactoryBot.create(:admin_user, created_at: 1.day.ago)
        user2 = FactoryBot.create(:admin_user, created_at: 2.days.ago)

        get :index, params: { q: { created_at_gteq: 2.days.ago, created_at_lteq: 1.day.ago } }

        expect(assigns(:admin_users)).to include(user2)
        expect(assigns(:admin_users)).not_to include(user1)
      end

    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end