require 'rails_helper'

RSpec.describe Admin::AdminRepliesController, type: :controller do
  render_views
 before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @admin_replies = create_list(:admin_reply, 2)
  end

  describe 'GET #index' do
    it 'returns a success index response' do
      get :index
      expect(response).to render_template(:index)
      @admin_replies.each do |admin_reply|
        expect(response.body).to include(admin_reply.description)
          if admin_reply.image.attached?
          image_url = Rails.application.routes.url_helpers.rails_blob_path(admin_reply.image, only_path: true)
          expect(response.body).to include(image_url)
        end
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success show response' do
      admin_reply = @admin_replies.first
      get :show, params: { id: admin_reply.id }
      expect(response).to render_template(:show)
        expect(response.body).to include(admin_reply.description)
          if admin_reply.image.attached?
          image_url = Rails.application.routes.url_helpers.rails_blob_path(admin_reply.image, only_path: true)
          expect(response.body).to include(image_url)
      end
    end
  end

  describe 'GET #new' do
    it 'returns a success new response' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it 'creates a new admin reply and sends notification' do
      post :create, params: { admin_reply: attributes_for(:admin_reply) }
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#send_notification' do
    it 'sends a notification email' do
       @admin_replies.each do |admin_reply|
      expect {
        controller.send(:send_notification, admin_reply)
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
      last_email = ActionMailer::Base.deliveries.last
      expect(last_email.to).to include(admin_reply.contact.email)
    end
    end
  end
end
