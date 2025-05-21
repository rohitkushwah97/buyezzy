require 'rails_helper'

RSpec.describe BxBlockCatalogue::Brand, type: :model do
  subject(:brand) { FactoryBot.build(:brand) }

  it { is_expected.to validate_presence_of(:brand_name) }
  it { is_expected.to validate_uniqueness_of(:brand_name).case_insensitive }
  it { is_expected.to validate_presence_of(:brand_website)}
  # it { is_expected.to validate_presence_of(:brand_name_arabic) }

  describe 'validates brand_website format' do
    context 'when brand_website is valid' do
      it 'is valid with http Url' do
        brand.brand_website = 'http://example.com'
        expect(brand).to be_valid
      end

      it 'is valid with https Url' do 
        brand.brand_website = 'https://example1.com'
        expect(brand).to be_valid
      end

      it 'is valid with www prefix' do
        brand.brand_website = 'www.example.com'
        expect(brand).to be_valid
      end
    end
    context 'when brand_website is invalid' do
      it 'is invalid with missing domain' do
        brand.brand_website = 'http://'
        expect(brand).not_to be_valid
        expect(brand.errors[:brand_website]).to include('is not valid url')
      end

      it 'is invalid with missing TLD' do
        brand.brand_website = 'http://example2'
        expect(brand).not_to be_valid
        expect(brand.errors[:brand_website]).to include('is not valid url')
      end

      it 'is invalid with spaces' do
        brand.brand_website = 'http://example .com'
        expect(brand).not_to be_valid
        expect(brand.errors[:brand_website]).to include('is not valid url')
      end

      it 'is invalid with non-URL strings' do
        brand.brand_website = 'not a url'
        expect(brand).not_to be_valid
        expect(brand.errors[:brand_website]).to include('is not valid url')
      end
    end
  end
  describe 'validates brand_year' do
    context 'when brand_year is within the valid range' do
      it 'is valid' do
        BxBlockCatalogue::Brand::YEARS.each do |year|
          brand.brand_year = year
          expect(brand).to be_valid
        end
      end
    end

    context 'when brand_year is not within the valid range' do
      it 'is invalid' do
        invalid_years = [-1000, 0, 1899, 3000]
        invalid_years.each do |year|
          brand.brand_year = year
          expect(brand).not_to be_valid
          expect(brand.errors[:brand_year]).to include('is not included in the list')
        end
      end
    end
  end

  describe 'branding_tradmark_certificate' do
    it 'is attached' do
      expect(brand).to respond_to(:branding_tradmark_certificate)
      expect(brand.branding_tradmark_certificate).to be_an_instance_of(ActiveStorage::Attached::One)
    end
  end

  describe 'strip_whitespace' do
    let(:brand_name) { 'ExampleBrand' }
    it 'removes leading and trailing whitespace from brand_name' do
      brand.brand_name = '  ExampleBrand  '
      brand.save!
      expect(brand.brand_name).to eq(brand_name)
    end

    it 'does not modify brand_name if there is no leading or trailing whitespace' do
      brand.brand_name = brand_name
      brand.save!
      expect(brand.brand_name).to eq(brand_name)
    end
  end

  describe '#approved_now?' do
    let(:brand) { FactoryBot.create(:brand, approve: false) }
    context 'when approve status changes from false to true' do
      it 'returns true' do
        brand.update(approve: true)
        expect(brand.send(:approved_now?)).to be true
      end
    end

    context 'when approve status remail false' do
      it 'return false' do
        brand.update(brand_name: 'Test')
        expect(brand.send(:approved_now?)).to be false
      end
    end
  end
end
