require 'rails_helper'

RSpec.describe Admin::WeeklyHomieeDealsController, type: :controller do  
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @deal = FactoryBot.create(:deal)
    @bg_image = fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "Sample.jpg"))
    @weekly_deals_attributes = [
      { caption: "slider1", discount_percent: 1.0, url: "https://slider1", deal: @deal, bg_image: @bg_image },
      { caption: "slider2", discount_percent: 2.0, url: "https://slider2", deal: @deal, bg_image: @bg_image },
      { caption: "slider3", discount_percent: 3.0, url: "https://slider3", deal: @deal, bg_image: @bg_image }
    ]
    @current_date = Date.current
    @tomorrow_date = Date.tomorrow + 2.days
    @yesterday_date = Date.yesterday

    @weekly_homiee_deal = create(:weekly_homiee_deal, weekly_deals_attributes: @weekly_deals_attributes)

  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: @weekly_homiee_deal.id }
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

  describe 'Validations' do
    context 'when validating max_weekly_deals' do

      it 'should add error message if weekly_deals size is not 3' do
        @weekly_homiee_deal.weekly_deals = []
        @weekly_homiee_deal.save
        expect(@weekly_homiee_deal.errors[:weekly_deals]).to include("must be exactly 3 and cannot be blank")
      end
    end

    context 'when validating end_date_must_be_today_or_later_and_present' do
      it 'should add error message if end_time is in the past' do
        @weekly_homiee_deal.end_time = @yesterday_date
        @weekly_homiee_deal.save
        expect(@weekly_homiee_deal.errors[:end_date]).to include("must be today or after start time")
      end
    end

    context 'when validating start_time_must_be_today_or_later_and_present' do
      it 'should add error message if start_time is in the past' do
        @weekly_homiee_deal.start_time = @yesterday_date
        @weekly_homiee_deal.save
        expect(@weekly_homiee_deal.errors[:start_time]).to include("must be today or later")
      end
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "filters by weekly_deals" do
      get :index, params: { q: { weekly_deals_id_eq: @weekly_homiee_deal.weekly_deals.first.id } }
      expect(assigns(:weekly_homiee_deals)).to include(@weekly_homiee_deal)
    end

    it "filters by start_time" do
      get :index, params: { q: { start_time_gteq: @current_date } }
      expect(assigns(:weekly_homiee_deals)).to include(@weekly_homiee_deal)
    end

    it "filters by end_time" do
      get :index, params: { q: { end_time_lteq: @tomorrow_date } }
      expect(assigns(:weekly_homiee_deals)).to include(@weekly_homiee_deal)
    end

    it "filters by status" do
      get :index, params: { q: { status_eq: 'No' } }
      expect(assigns(:weekly_homiee_deals)).to include(@weekly_homiee_deal)
    end

    it "filters by created_at" do
      get :index, params: { q: { created_at_gteq: @current_date } }
      expect(assigns(:weekly_homiee_deals)).to include(@weekly_homiee_deal)
    end

    it "filters by updated_at" do
      get :index, params: { q: { updated_at_gteq: @current_date } }
      expect(assigns(:weekly_homiee_deals)).to include(@weekly_homiee_deal)
    end
  end

end
