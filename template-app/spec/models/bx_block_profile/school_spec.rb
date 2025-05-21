require 'rails_helper'

RSpec.describe BxBlockProfile::School, type: :model do

  let!(:educational_status) { FactoryBot.create(:educational_status, name: "High School", code: "SCH") }
  let!(:school) { FactoryBot.create(:school, name: "DPS", educational_status_id: educational_status.id)}

  context 'Validations' do
    it { should validate_presence_of :name }
    it 'check uniqueness of name' do
      res = BxBlockProfile::School.new(name: "dps", educational_status_id: educational_status.id)
      expect(res.valid?).to eq(false)
    end
  end

  context 'Associations' do
    it 'belongs to educational_status' do
      expect(school.educational_status).to eq(educational_status)
    end
  end
end
