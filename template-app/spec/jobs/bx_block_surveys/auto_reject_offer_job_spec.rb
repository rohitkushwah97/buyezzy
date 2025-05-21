require 'rails_helper'

RSpec.describe BxBlockSurveys::AutoRejectOfferJob, type: :job do
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

  let!(:recent_offer) do
    BxBlockSurveys::MakeOffer.create!(
      internship_id: internship.id,
      intern_user_id: intern_user.id,
      business_user_id: business_user.id,
      offer_status: :pending,
      number_of_days: 3,
      created_at: 6.days.ago
    )
  end

  let!(:old_offer) do
    BxBlockSurveys::MakeOffer.create!(
      internship_id: internship.id,
      intern_user_id: intern_user2.id,
      business_user_id: business_user.id,
      offer_status: :pending,
      number_of_days: 2,
      created_at: 8.days.ago
    )
  end

  describe '#perform' do
    it 'rejects offers whose number_of_days has expired and leaves valid ones pending' do
      recent_offer.update!(created_at: 1.day.ago)

      described_class.perform_now

      expect(old_offer.reload.offer_status).to eq('rejected')
      expect(recent_offer.reload.offer_status).to eq('pending')
    end
  end

end
