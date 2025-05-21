require 'rails_helper'

RSpec.describe AccountBlock::Account, type: :model do
  describe 'should have has_one association' do
    it { should have_one(:blacklist_user).class_name('AccountBlock::BlackListUser').dependent(:destroy) }
  end

  describe 'should have has_many association' do
    it { should have_many(:stores).class_name('BxBlockStoreManagement::Store').dependent(:destroy) }
    it { should have_many(:seller_documents).class_name('AccountBlock::SellerDocument').dependent(:destroy) }
    it { should have_many(:user_delivery_addresses).class_name('AccountBlock::UserDeliveryAddress').dependent(:destroy) }
    it { should have_many(:seller_documents).class_name('AccountBlock::SellerDocument').dependent(:destroy) }
    it { should have_many(:user_delivery_addresses).class_name('AccountBlock::UserDeliveryAddress').dependent(:destroy) }
    it { should have_many(:brands).class_name('BxBlockCatalogue::Brand').dependent(:destroy) }
    it { should have_many(:favourites).class_name('BxBlockFavourites::Favourite').with_foreign_key('user_id').dependent(:destroy) }
    it { should have_many(:orders).class_name('BxBlockShoppingCart::Order').with_foreign_key('customer_id').dependent(:destroy) }
    it { should have_many(:subscribe_coupons).class_name('BxBlockCouponCg::SubscribeCoupon').dependent(:destroy) }
    it { should have_many(:coupon_codes).through(:subscribe_coupons).class_name('BxBlockCouponCg::CouponCode') }
    it { should have_many(:review_and_ratings).class_name('BxBlockCatalogue::Review').dependent(:destroy) }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values(%i[regular suspended deleted]) }
  end

  describe 'scopes' do
    let!(:buyer_account) { create(:account, user_type: 'buyer') }
    let!(:seller_account) { create(:account, user_type: 'seller') }

    describe '.buyer_accounts' do
      it 'returns accounts with user_type "buyer"' do
        expect(AccountBlock::Account.buyer_accounts).to include(buyer_account)
        expect(AccountBlock::Account.buyer_accounts).not_to include(seller_account)
      end
    end
  end
end
