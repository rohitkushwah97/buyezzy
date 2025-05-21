require 'rails_helper'

RSpec.describe BxBlockProfile::University, type: :model do

  let!(:educational_status) { FactoryBot.create(:educational_status, name: "University", code: "UNI") }
  let!(:university) { FactoryBot.create(:university, name: "DAVV", educational_status_id: educational_status.id) }

  context 'Validations' do
    it { should validate_presence_of :name }
    it 'check uniqueness of name' do
      res = BxBlockProfile::University.new(name: "davv", educational_status_id: educational_status.id)
      expect(res.valid?).to eq(false)
    end
  end

  context 'Associations' do
    it 'belongs to educational_status' do
      university = FactoryBot.create(:university, name: "Sandford", educational_status_id: educational_status.id)
      
      expect(university.educational_status).to eq(educational_status)
    end
  end
end
