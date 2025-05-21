require 'rails_helper'

RSpec.describe BxBlockStoreManagement::Store, type: :model do
  describe 'attachment' do
    it { should have_one_attached(:brand_trade_certificate) }
  end

  describe 'validations' do
    it { should validate_presence_of(:store_year) }
    it { should validate_presence_of(:store_url) }
    it { should validate_presence_of(:website_social_url) }
  end

  describe 'associations' do
    it { should belong_to(:account).class_name('AccountBlock::Account').optional }
    it { should belong_to(:brand).class_name('BxBlockCatalogue::Brand') }
    it { should have_many(:store_menus).class_name('BxBlockStoreManagement::StoreMenu').dependent(:destroy) }
  end
end 