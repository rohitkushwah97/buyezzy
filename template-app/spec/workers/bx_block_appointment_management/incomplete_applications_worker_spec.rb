require 'rails_helper'

RSpec.describe BxBlockAppointmentManagement::IncompleteApplicationsWorker, type: :worker do
  let(:business_user) { create(:business_user) }
  let(:internship_draft) { create(:bx_block_navmenu_internship, business_user: business_user, status: 'draft') }
  let(:internship_active) { create(:bx_block_navmenu_internship, business_user: business_user, status: 'active') }

  describe "#perform" do
    context "when internships are in draft status" do
      it "sends notification for internships in draft status" do
        internship_draft
        described_class.new.perform
        notification = BxBlockNotifications::Notification.last
        expect(notification.headings).to eq('Incomplete Applications')
        expect(notification.navigates_to).to eq('IncompleteDraft')
      end
    end
  end
end
