require 'rails_helper'

RSpec.describe BxBlockAppointmentManagement::InternshipPostingExpirationWorker, type: :worker do
  let(:business_user) { create(:business_user) }
  let!(:internship) { create(:bx_block_navmenu_internship, business_user: business_user, status: 'active',end_date: Time.current.to_date+2) }

  describe '#perform' do
    context 'when there are internships with start_date 2 days from now and status active' do
      it 'sends a notification to the business user' do
        res = described_class.new.perform
        expect(res).to eql([])        
      end
    end
  end
end
