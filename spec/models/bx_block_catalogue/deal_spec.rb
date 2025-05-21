require 'rails_helper'

RSpec.describe BxBlockCatalogue::Deal, type: :model do

  it "is valid when end date is after start date" do
    deal = build(:deal, start_date: Date.today, end_date: Date.tomorrow,status: true)
    expect(deal).to be_valid
  end

  it "is invalid when end date is before start date" do
    deal = build(:deal, start_date: Date.tomorrow, end_date: Date.today,status: true)
    expect(deal).to be_invalid
    expect(deal.errors[:end_date]).to include("must be after the start date")
  end

  it "validates presence and length of deal_name and deal_code" do
    deal = build(:deal, 
      deal_name: "dealnameeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", 
      deal_code: "dealcodeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", 
    )
    expect(deal).to be_invalid
    expect(deal.errors[:deal_name]).to include("is too long (maximum is 50 characters)")
    expect(deal.errors[:deal_code]).to include("is too long (maximum is 50 characters)")
  end

end
