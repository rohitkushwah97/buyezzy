require 'rails_helper'

RSpec.describe BxBlockNotifications::PendingSurveyNotificationWorker, type: :worker do
  let(:industry) { create(:industry) }
  let(:role) { create(:role, industry_id: industry.id) }
  let(:intern_user) { create(:intern_user) }
  let!(:career_intrest) { create(:career_interest,role_id: role.id,intern_user_id: intern_user.id) }

  describe "#perform" do
    context "when user survey is in pending state" do
      it "sends notification for pending survey" do
        described_class.new.perform
        notification = BxBlockNotifications::Notification.last
        expect(notification.headings).to eq('Pending quiz')
        expect(notification.navigates_to).to eq('PendingQuizIntern')
      end
    end
  end
end
