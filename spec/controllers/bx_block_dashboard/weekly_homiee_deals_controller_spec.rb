require 'rails_helper'

RSpec.describe BxBlockDashboard::WeeklyHomieeDealsController, type: :controller do

 before do
    @deal = FactoryBot.create(:deal)
    @bg_image = fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "Sample.jpg"))
    weekly_deals_attributes = [
      { caption: "slider1", discount_percent: 1.0, url: "https://slider1", deal: @deal, bg_image: @bg_image },
      { caption: "slider2", discount_percent: 2.0, url: "https://slider2", deal: @deal, bg_image: @bg_image },
      { caption: "slider3", discount_percent: 3.0, url: "https://slider3", deal: @deal, bg_image: @bg_image }
    ]

    @weekly_homiee_deal = create(:weekly_homiee_deal, status: true, weekly_deals_attributes: weekly_deals_attributes)

  end
  
  describe 'GET #index' do
    it 'returns a successful response with a list of deals' do
      get :index

      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data'].length).to eq(BxBlockDashboard::WeeklyHomieeDeal.all.count)
    end
  end

  describe 'GET #show' do

    it 'returns a successful response with the details of a deal' do
      get :show, params: { id: @weekly_homiee_deal.id }

      expect(response).to have_http_status(:success)
      parsed_response_2 = JSON.parse(response.body)
      expect(parsed_response_2['data']['id']).to eq(@weekly_homiee_deal.id.to_s)
      expect(parsed_response_2['data']['attributes']['weekly_deals'][0]).to have_key('bg_image')
    end

  end

  describe 'GET #latest_weekly_deal' do

    it 'latest_weekly_deal returns a successful response with the details of a deal' do
      get :latest_weekly_deal, params: { id: @weekly_homiee_deal.id }

      expect(response).to have_http_status(:success)
      parsed_response_3 = JSON.parse(response.body)
      expect(parsed_response_3['data']['id']).to eq(@weekly_homiee_deal.id.to_s)
    end

  end
end
