require 'rails_helper'

RSpec.describe Admin::AdminNotificationsController, type: :controller do
  render_views
  let!(:admin) { create(:admin) }
  let!(:notification) { create(:admin_notification, :with_attachment) }

  before(:each) do
    sign_in admin
  end

  describe 'index page' do
    it 'displays notifications with correct columns' do
      get :index
      expect(response.body).to include(notification.id.to_s)
    end

    it 'shows attachment link if attached' do
      get :index
      expect(response.body).to include(rails_blob_path(notification.attachment, disposition: 'attachment'))
    end
  end

  describe 'show page' do
    it 'displays notification details correctly' do
      get :show, params: { id: notification.id }
      expect(response.body).to include(notification.message)
    end

    it 'shows attachment link on the show page' do
      get :show, params: { id: notification.id }
      expect(response.body).to include(notification.attachment.filename.to_s)
    end
  end

  describe 'destroy action' do
    it 'deletes the notification' do
      expect {
        delete :destroy, params: { id: notification.id }
      }.to change(BxBlockNotifications::AdminNotification, :count).by(-1)
    end
  end
end
