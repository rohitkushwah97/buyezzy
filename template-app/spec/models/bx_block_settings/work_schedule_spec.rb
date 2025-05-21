require 'rails_helper'

RSpec.describe BxBlockSettings::WorkSchedule, type: :model do
  let!(:schedule) { FactoryBot.create(:work_schedule, schedule: "part_time")}
  describe "Work schedule" do
    
    context "validations" do
    	it { should validate_presence_of(:schedule) }
      it 'check uniqueness of schedule' do
        res = BxBlockSettings::WorkSchedule.new(schedule: "part_time")
        expect(res.valid?).to eq(false)
      end
    end
  end
  
end
