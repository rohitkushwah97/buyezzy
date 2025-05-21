require 'rails_helper'
 
RSpec.describe Admin::BlockUsersController, type: :controller do
  render_views
  
  let!(:account) { create(:account, full_name: "John Doe", email: "john@example.com") }
  let!(:current_user) { create(:account, first_name: "Cedric") }
  let!(:block_user) { create(:block_user, current_user: current_user, account: account) }

  before(:each) do
    admin =  FactoryBot.create(:admin)
    sign_in admin
  end

  describe 'Blocked users index page' do

    it 'displays blocked users with correct details' do
      get :index
      expect(response.body).to include(block_user.current_user.full_name.to_s)
      expect(response.body).to include(block_user.account.full_name)
      expect(response.body).to include(block_user.account.email)
      expect(response.body).to include(block_user.account.type.to_s)
      expect(response.body).to include(block_user.account.activated.to_s)
      expect(response.body).to include(block_user.account.created_at.strftime('%Y'))
      expect(response.body).to include(block_user.account.updated_at.strftime('%Y'))
    end
  end


  describe 'Blocked user show' do
    let(:block_user) { create(:block_user)}

    it 'displays blocked account details' do
      get :show, params: { id: block_user.id}
      expect(response.body).to be_present
    end
  end
end