require 'rails_helper'

RSpec.describe BxBlockCatalogue::Review, type: :model do 
	
  describe 'associations' do
    it { should belong_to(:catalogue).class_name('BxBlockCatalogue::Catalogue')}
    it { should belong_to(:account).with_foreign_key('reviewer_id').class_name('AccountBlock::Account')}
  end

  describe 'validation' do
    it { should validate_presence_of(:reviewer_id) }
    it { should validate_presence_of(:catalogue_id) }
    it { should validate_presence_of(:rating) }
  end

  describe 'scopes' do
    let!(:approved_review) { create(:review, is_approved: true) }
    let!(:seller_review) { create(:review, review_type: 'seller') }

    describe '.approved_reviews' do
      it 'returns approved reviews' do
        expect(BxBlockCatalogue::Review.approved_reviews).to include(approved_review)
      end
    end

     describe '.seller_reviews' do
      it 'returns seller reviews' do
        expect(BxBlockCatalogue::Review.seller_reviews).to include(seller_review)
      end
    end
  end

   describe 'validations' do
    it 'validates that rating is greater than or equal to 1' do
      should validate_numericality_of(:rating).is_greater_than_or_equal_to(1)
    end

    it 'validates that rating is less than or equal to 5' do
      should validate_numericality_of(:rating).is_less_than_or_equal_to(5)
    end
  end
end 
