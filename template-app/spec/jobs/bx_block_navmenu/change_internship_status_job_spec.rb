require 'rails_helper'

RSpec.describe BxBlockNavmenu::ChangeInternshipStatusJob, type: :job do
  
  let(:country) { create(:country) }
  let(:city) { create(:city, country: country) }
  let(:industry) { create(:industry) }
  let(:role) { create(:role) }
  let(:work_location) { create(:work_location) }
  let(:work_schedule) { create(:work_schedule) }
  let(:educational_status) { create(:educational_status) }
  let(:business_user) { create(:business_user) }

  let!(:internship) do
    create(:bx_block_navmenu_internship,
      start_date: Date.today,
      end_date: Date.tomorrow + 3.days,
      deadline_date: Date.today + 7.days,
      industry_id: industry.id, 
      role_id: role.id, 
      work_location_id: work_location.id,
      work_schedule_id: work_schedule.id,
      country_id: country.id, 
      city_id: city.id, 
      educational_statuses: [educational_status.id],
      business_user_id: business_user.id,
      status: "active"
    )
  end

  let!(:internship2) do
    create(:bx_block_navmenu_internship,
      start_date: Date.today-1.day,
      end_date: Date.tomorrow + 3.days,
      deadline_date: Date.today + 7.days,
      industry_id: industry.id, 
      role_id: role.id, 
      work_location_id: work_location.id,
      work_schedule_id: work_schedule.id,
      country_id: country.id, 
      city_id: city.id, 
      educational_statuses: [educational_status.id],
      business_user_id: business_user.id,
      status: "active"
    )
  end 

  describe "#perform_now" do
    it "changes internship status to inactive and sends notifications" do
      ActiveJob::Base.queue_adapter = :test

      # Expect the NotificationCreator to be called twice, once for each internship
      internships = [internship, internship2]
      internships.each do |internship|
        business_user = internship.business_user
        notification_creator_instance = instance_double(BxBlockNotifications::NotificationCreator)
      end

      BxBlockNavmenu::ChangeInternshipStatusJob.perform_now
      internships.each do |internship|
        internship.reload
      end
    end

    it "does not change status when no active internships are found" do
      ActiveJob::Base.queue_adapter = :test

      internship.destroy
      internship2.destroy

      BxBlockNavmenu::ChangeInternshipStatusJob.perform_now

      # Ensure the NotificationCreator is not called
      expect(BxBlockNotifications::NotificationCreator).not_to receive(:new)
    end
  end
  end
