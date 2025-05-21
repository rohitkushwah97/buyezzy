require 'rails_helper'

RSpec.describe Admin::CouponsController, type: :controller do
  render_views
  let(:admin_user) { create(:admin_user) }
  let!(:coupon) { create(:coupon) }
  let(:valid_attributes) do
    {
      title: Faker::Lorem.unique.sentence,
      code: SecureRandom.hex(8),
      discount: Faker::Number.between(from: 5, to: 50),
      valid_from: Faker::Date.backward(days: 10),
      valid_to: Faker::Date.forward(days: 10)
    }
  end

  before do
    sign_in admin_user
  end

  describe "POST #create coupon" do
    context "coupon with valid attributes" do
      it "creates a new coupon record" do
        post :create, params: { coupon: valid_attributes }
        expect(response).to have_http_status(:success)
      end

      it "creates a new Coupon record" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "UPDATE#Coupon" do
    it 'should update coupon' do
      patch :update, params: {id: coupon.id, coupon: valid_attributes }
      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE #Coupon" do
    it 'should delete coupon' do
      delete :delete_coupon, params: { id: coupon.id }
      expect(response).to have_http_status(302)
    end
  end

  describe "INDEX#Coupon" do
    it 'should index coupons' do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "SHOW#Coupon" do
    it 'should show coupon' do
      get :show, params: {id: coupon.id}
      expect(response).to have_http_status :success
    end
  end
end