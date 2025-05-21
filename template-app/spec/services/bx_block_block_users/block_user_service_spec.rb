# spec/services/bx_block_block_users/block_user_service_spec.rb
require 'rails_helper'

RSpec.describe BxBlockBlockUsers::BlockUserService, type: :service do
  let(:intern_user) { create(:account, type: 'InternUser') }
  let(:business_user) { create(:account, type: 'BusinessUser') }
  let(:target_user) { create(:account) }
  let(:internship_future) { create(:bx_block_navmenu_internship, start_date: Date.tomorrow, end_date: Date.tomorrow + 10) }
  let(:internship_current) { create(:bx_block_navmenu_internship, start_date: Date.today, end_date: Date.today + 5) }

  before do
    target_user.internships << internship_future
    target_user.internships << internship_current

    create(:accounts_bx_block_navmenu_internships, account: intern_user, internship: internship_future)
    create(:accounts_bx_block_navmenu_internships, account: intern_user, internship: internship_current)
    create(:accounts_bx_block_navmenu_internships, account: business_user, internship: internship_future)
    create(:accounts_bx_block_navmenu_internships, account: business_user, internship: internship_current)
  end

  context 'when current user is an InternUser' do
    it 'withdraws or terminates internship applications' do
      service = described_class.new(target_user, intern_user)
      service.block_user

      future_app = BxBlockNavmenu::AccountInternship.find_by(account: intern_user, internship: internship_future)
      current_app = BxBlockNavmenu::AccountInternship.find_by(account: intern_user, internship: internship_current)

      expect(future_app.is_withdraw).to be true
      expect(current_app.is_terminate).to be true
    end
  end

  context 'when current user is a BusinessUser' do
    it 'rejects or terminates internships' do
      service = described_class.new(target_user, business_user)
      service.block_user

      future_app = BxBlockNavmenu::AccountInternship.find_by(account: business_user, internship: internship_future)
      current_app = BxBlockNavmenu::AccountInternship.find_by(account: business_user, internship: internship_current)

      expect(future_app.status).to eq("rejected")
      expect(current_app.is_terminate).to be true
    end
  end
end
