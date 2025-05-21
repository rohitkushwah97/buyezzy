require 'rails_helper'

RSpec.describe BxBlockNotifications::NotificationsController, type: :controller do
  include BuilderJsonWebToken::JsonWebTokenValidation
  
  let(:current_user) { FactoryBot.create(:account) }
  let!(:notifications) { create_list(:notification, 3, account_id: current_user.id, is_read: false) }
  let!(:read_notification) { create(:notification, account_id: current_user.id, is_read: true) }
  let!(:unread_notification) { create(:notification, account_id: current_user.id) }

  let(:token) do
    BuilderJsonWebToken::JsonWebToken.encode(current_user.id)
  end
  before do
    request.headers['token'] = "#{token}"
    allow(controller).to receive(:authenticate_account).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)
    # request.headers.merge!(valid_headers)
  end

  describe "GET #unread_notifications" do
    it "if unread notifications present" do
      get :unread_notifications
      expect(response).to have_http_status(:ok)
      expect(json['unread_notifications']).to eq(true)
    end
  end

  describe "GET #index" do
    it "returns a list of unread notifications" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "returns a list of unread notifications with pagination" do
      get :index, params: { page: 1, per_page: 1 }
      expect(response).to have_http_status(:ok)
    end

    it "returns an empty list if there are no unread notifications" do
      BxBlockNotifications::Notification.update_all(is_read: true)
      get :index
      expect(response).to have_http_status(:ok)
      # expect(json["errors"][0]["message"]).to eq('No notification found.')

      get :show, params: { id: notifications.first.id }
      expect(response).to have_http_status(:ok)
      expect(json["data"]["id"]).to eq(notifications.first.id.to_s)
    end
  end
  
  describe "GET #index" do
    it "returns an empty list if there are no unread notifications" do
      BxBlockNotifications::Notification.update_all(is_read: true)
      get :index
      expect(response).to have_http_status(:ok)

      get :show, params: { id: notifications.first.id }
      expect(response).to have_http_status(:ok)
      expect(json["data"]["id"]).to eq(notifications.first.id.to_s)
    end
  end

  describe "POST #create" do
    let(:notification_params) do
      {
        headings: "New Heading",
        contents: "This is a test content."
      }
    end
    let(:invalid_notification_params) { { contents: "", headings: "" } }

    it "creates a new notification" do
      expect {
        post :create, params: { notification: notification_params }
      }.to change(BxBlockNotifications::Notification, :count).by(1)
      expect(response).to have_http_status(:created)
      expect(json["meta"]["message"]).to eq("Notification created.")
    end

    it "returns formatted validation errors" do
      post :create, params: { notification: invalid_notification_params }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT #update" do
    it "marks a notification as read" do
      patch :update, params: { id: notifications.first.id }
      expect(response).to have_http_status(:ok)
      expect(json["meta"]["message"]).to eq("Notification marked as read.")
      expect(notifications.first.reload.is_read).to be_truthy
    end
  end

  describe "DELETE #destroy" do
    it "deletes the notification" do
      expect {
        delete :destroy, params: { id: notifications.first.id }
      }.to change(BxBlockNotifications::Notification, :count).by(-1)
      expect(response).to have_http_status(:ok)
      expect(json["message"]).to eq("Deleted.")
    end
  end

  describe "PUT #mark_all_read" do
    it "marks all notifications as read" do
      patch :mark_all_read
      expect(response).to have_http_status(:ok)
      expect(json["message"]).to eq("All notifications marked as read.")
      expect(BxBlockNotifications::Notification.where(account_id: current_user.id, is_read: false)).to be_empty
    end
  end

   describe "PUT #mark_as_read" do\
    it "marks all notifications as read" do
      patch :mark_as_read, params: { id: unread_notification.id }
      expect(response).to have_http_status(:ok)
      expect(json["message"]).to eq("Your notification is marked as read.")
    end
  end

  private

  def json
    JSON.parse(response.body)
  end
end
