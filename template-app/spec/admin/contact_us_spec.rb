require 'rails_helper'

RSpec.describe Admin::ContactUsController, type: :controller do
  render_views

  before(:each) do
    admin = FactoryBot.create(:admin)
    @inquiry_details = FactoryBot.create(:inquiry_details)
    sign_in admin
  end

  describe 'Contact Us #index' do
    it "should have http response success for #index" do
      get :index
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end
  end

  describe 'Contact Us #show' do
    it 'should have http response success for #show' do
      get :show, params: { id: @inquiry_details.id }
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end
  end
end