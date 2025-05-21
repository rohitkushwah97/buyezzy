require 'rails_helper'

RSpec.describe Admin::WeeklyDealsController, type: :controller do  
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @deal = FactoryBot.create(:deal)
    @bg_image = fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "Sample.jpg"))
    weekly_deals_attributes = [
      { caption: "slider1", discount_percent: 1.0, url: "https://slider1", deal: @deal, bg_image: @bg_image },
      { caption: "slider2", discount_percent: 2.0, url: "https://slider2", deal: @deal, bg_image: @bg_image },
      { caption: "slider3", discount_percent: 3.0, url: "https://slider3", deal: @deal, bg_image: @bg_image }
    ]

    @weekly_homiee_deal_d = create(:weekly_homiee_deal, weekly_deals_attributes: weekly_deals_attributes)

  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: @weekly_homiee_deal_d.weekly_deals.first.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

end
