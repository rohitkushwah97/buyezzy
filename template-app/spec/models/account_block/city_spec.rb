require 'rails_helper'

RSpec.describe AccountBlock::City, type: :model do
  let!(:country) {FactoryBot.create(:country, name: "india")}
  let(:city) {FactoryBot.create(:city, country_id: country.id)}
  describe "Country" do
    
    context "validations" do
    	it { should validate_presence_of(:name) }
      it 'check uniqueness of name' do
        res = AccountBlock::City.new(name: "GwaliOR")
        expect(res.valid?).to eq(false)
      end
    end
  end
  
end
