require 'rails_helper' 
require 'simplecov'
RSpec.describe BxBlockNotifsettings::NotificationSettingsController, type: :request do
  let!(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let!(:business_user) { FactoryBot.create(:business_user, activated: true) }
  let(:token) { get_token(intern_user) }
  let(:token2) { get_token(business_user) }
  let(:url) { "/bx_block_notifsettings/notification_settings"}

  let(:valid_params) {
    {
     turn_off_deadline_reminders: false,
     turn_off_perfect_match_notifications: false
    }
  }

  describe "GET /show notification setting for intern user" do
    it "When show intern setting" do
      get url, headers: {token: token}
      expect(response).to have_http_status(200)
      res = json_response
      expect(res["data"]["attributes"]["turn_off_deadline_reminders"]).to eql(true)
      expect(res["data"]["attributes"]["turn_off_perfect_match_notifications"]).to eql(true)
    end

    it "When show business setting" do
      get url, headers: {token: token2}
      expect(response).to have_http_status(200)
      res = json_response
      expect(res["data"]["attributes"]["turn_off_feedback_requests"]).to eql(true)
      expect(res["data"]["attributes"]["turn_off_recommendation_notifications"]).to eql(true)
    end

    it "When intern user setting is not available" do
      intern_user.notification_setting.destroy
      get url, headers: {token: token}
      expect(response).to have_http_status(404)
      res = json_response
      expect(res["message"]).to eql("Notification setting not found.")
    end

    it "When business user setting is not available" do
      business_user.notification_setting.destroy
      get url, headers: {token: token2}
      expect(response).to have_http_status(404)
      res = json_response
      expect(res["message"]).to eql("Notification setting not found.")
    end
  end

  describe "PUT /update notification setting" do
    context "When updation perform successfully" do
      it "When intern user successfully updated" do
        put url, headers: {token: token}, params: valid_params
        expect(response).to have_http_status(200)
        res = json_response
        expect(res["data"]["attributes"]["turn_off_deadline_reminders"]).to eql(false)
        expect(res["data"]["attributes"]["turn_off_perfect_match_notifications"]).to eql(false)
      end

      it "When business user successfully updated" do
        put url, headers: {token: token2}, params: valid_params
        expect(response).to have_http_status(200)
        res = json_response
        expect(res["data"]["attributes"]["turn_off_deadline_reminders"]).to eql(false)
        expect(res["data"]["attributes"]["turn_off_perfect_match_notifications"]).to eql(false)
      end
    end
  end
end