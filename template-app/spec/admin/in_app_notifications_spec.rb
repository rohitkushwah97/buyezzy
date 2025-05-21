require 'rails_helper'

RSpec.describe Admin::InAppNotificationsController, type: :controller do
  render_views

  before(:each) do
    admin =  FactoryBot.create(:admin)
    @business_user = FactoryBot.create(:business_user)
    @intern_user = FactoryBot.create(:intern_user)
    @intern_notification = FactoryBot.create(:notification,account_id:@intern_user.id)
    @business_notification = FactoryBot.create(:notification,account_id:@business_user.id)
    sign_in admin
  end

  describe "Notification #index" do
    context "GET index" do 
      it "should have http success for index" do 
      get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
 
  describe "Notification #show" do
    context "GET show" do 
      it "should have http success for show notification for intern_user" do 
        get :show,params: { id: @intern_notification.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end

      it "should have http success for show notification for business_user" do 
        get :show,params: { id: @business_notification.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end
end