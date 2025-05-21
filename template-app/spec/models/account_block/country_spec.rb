require 'rails_helper'

RSpec.describe AccountBlock::Country, type: :model do
  let!(:country) {FactoryBot.create(:country, name: "india")}
  describe "Country" do
    
    context "validations" do
    	it { should validate_presence_of(:name) }
      it 'check uniqueness of name' do
        res = AccountBlock::Country.new(name: "INDIA")
        expect(res.valid?).to eq(false)
      end
    end
  end
  
end
