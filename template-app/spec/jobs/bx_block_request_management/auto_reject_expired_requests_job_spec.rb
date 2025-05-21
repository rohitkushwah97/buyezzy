require 'rails_helper'

RSpec.describe BxBlockRequestManagement::AutoRejectExpiredRequestsJob, type: :job do
  before do
    ActiveJob::Base.queue_adapter = :test
  end

  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let(:intern_user2) { FactoryBot.create(:intern_user, activated: true) }
  let(:business_user) { FactoryBot.create(:business_user) }  
  let(:country) { create(:country) }
  let(:city) { create(:city, country: country) }
  let(:industry) { create(:industry) }
  let(:industry1) { create(:industry) }
  let(:work_location) { create(:work_location) }
  let(:work_schedule) { create(:work_schedule) }
  let(:educational_status) { FactoryBot.create(:educational_status, name: "High school", code: "SCH") }
  let(:version) { FactoryBot.create(:version) }

  let!(:career_interest) do
    FactoryBot.create(:career_interest, intern_user_id: intern_user.id, role_id: version.survey.role_id)
  end

  let!(:internship) do
    create(:bx_block_navmenu_internship,
      start_date: Date.today + 2.days,
      end_date: Date.today + 3.days, 
      industry_id: industry.id, 
      role_id: version.survey.role_id, 
      work_location_id: work_location.id,
      work_schedule_id: work_schedule.id,
      country_id: country.id, 
      city_id: city.id, 
      educational_statuses: [educational_status.id], 
      business_user_id: business_user.id,
      status: 0
    )
  end

  let!(:request_interview) do
    BxBlockRequestManagement::RequestInterview.create!(
      internship_id: internship.id,
      intern_user_id: intern_user.id,
      business_user_id: business_user.id,
      number_of_days: 3,
      created_at: 4.days.ago
    )
  end

  let!(:request_interview2) do
    BxBlockRequestManagement::RequestInterview.create!(
      internship_id: internship.id,
      intern_user_id: intern_user2.id,
      business_user_id: business_user.id,
      number_of_days: 3,
      created_at: 2.days.ago
    )
  end

  describe '#perform' do

    it 'rejects only the expired requests' do
      expect {
        described_class.perform_now
      }.to change {
        BxBlockRequestManagement::RequestInterview.rejected.count
      }.by(1)
    end
  end
end
