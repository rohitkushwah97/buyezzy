require 'rails_helper'

RSpec.describe BxBlockSettings::WorkLocation, type: :model do
  let!(:location) {FactoryBot.create(:work_location, name: "remote")}
  describe "Work location" do
    
    context "validations" do
    	it { should validate_presence_of(:name) }
      it 'check uniqueness of name' do
        res = BxBlockSettings::WorkLocation.new(name: "remote")
        expect(res.valid?).to eq(false)
      end
    end
  end
  
end
