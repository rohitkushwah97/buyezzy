require 'rails_helper'
RSpec.describe BxBlockCouponCg::SubscribeCouponsController, type: :controller do
  
  let (:coupon) {create(:coupon)}
  let (:catalogue) {create(:catalogue)}
  let(:account) { FactoryBot.create(:account, user_type: 'seller') }
  let (:subscribe_coupon) { FactoryBot.create(:subscribe_coupon, account_id: account.id, catalogue_id: catalogue.id, coupon_code_id: coupon.id) } 

  before(:each) do
    @token = BuilderJsonWebToken.encode(account.id)
  end

  describe 'GET#Subscribe Coupon Listing' do
    context 'list of subscribe coupons' do
      it 'should return subscribe coupons' do 
        get :index, params: { token: @token }
        expect(response).to have_http_status :ok
      end
    end
  end

  describe 'POST#Subscribe coupon' do
    context 'Subscribe coupon' do
      it 'should  subscribe coupon' do 
        get :create, params: { token: @token, catalogue_id: catalogue.id, coupon_code_id: coupon.id }
        expect(response).to have_http_status :created
      end

      it 'should not subscribe coupon' do 
        get :create, params: { token: @token, coupon_code_id: 0 }
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

   describe 'PUT#Subscribe coupon' do
    context 'update subscribe coupon' do
      it 'should update subscribe coupon' do
        put :update, params: { token: @token, id: subscribe_coupon.id, catalogue_id: catalogue.id, coupon_code_id: coupon.id }
        expect(response).to have_http_status :ok
      end
    end
  end

  describe 'DELETE#Subscribe coupon' do
    context 'delete subscribe coupon' do
      it 'should delete subscribe coupon' do
        delete :destroy, params: { token: @token, id: subscribe_coupon.id }
        expect(response).to have_http_status :ok
      end
    end
  end
end