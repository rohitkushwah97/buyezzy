require 'rails_helper'
RSpec.describe BxBlockCouponCg::CouponCodesController, type: :controller do
  
  let (:coupon) {create(:coupon)}
  let(:account) { FactoryBot.create(:account, user_type: 'seller') }
  before(:each) do
    @token = BuilderJsonWebToken.encode(account.id)
  end

  describe 'GET#Coupon Listing' do
    context 'list of active coupons' do
      it 'should return active coupons' do 
        get :index, params: { token: @token }
        expect(response).to have_http_status :ok
      end
    end
  end

  describe 'GET# Show Coupon' do
    context 'Show active coupon' do
      it 'should show active coupon' do 
        get :show, params: { token: @token, id: coupon.id }
        expect(response).to have_http_status :ok
      end

      it 'should not show active coupon' do 
        get :show, params: { token: @token, id: 0 }
        expect(response).to have_http_status :not_found
      end
    end
  end
end