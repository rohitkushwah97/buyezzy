require 'rails_helper'

RSpec.describe Admin::ActivityLogsController, type: :controller do
  render_views
 

  before do
    @admin = FactoryBot.create(:admin_user)
    @account = FactoryBot.create(:account, user_type: "seller")
    @activity = FactoryBot.create(:activity_log, user: @account)
    sign_in @admin
  end

  describe 'GET #index' do
    it 'returns a success index response' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'returns a success show response' do
      get :show, params: { id: @activity.id }
      expect(response).to render_template(:show)
    end
  end
end
