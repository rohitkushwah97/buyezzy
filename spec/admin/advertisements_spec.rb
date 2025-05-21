require 'rails_helper'

RSpec.describe Admin::CustomAdsController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @advertisement = FactoryBot.create(:advertisement)
    @strftime = '%B %d, %Y %H:%M'
    @strftime_1 = "%Y-%m-%d 00:00:00"
    @strftime_2 = "%Y-%m-%d 23:59:59"
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to include(@advertisement.name)
      expect(response.body).to include(@advertisement.description&.truncate(30))
      expect(response.body).to include(@advertisement.duration)
      expect(response.body).to include(@advertisement.start_at.strftime(@strftime))
      expect(response.body).to include(@advertisement.expire_at.strftime(@strftime))

      expect(response.body).to include(@advertisement.status)
    end

    context 'with filters' do
      it 'filters by name' do
        get :index, params: { q: { name_cont: @advertisement.name } }
        expect(assigns(:custom_ads)).to include(@advertisement)
      end

      it 'filters by description' do
        get :index, params: { q: { description_cont: @advertisement.description } }
        expect(assigns(:custom_ads)).to include(@advertisement)
      end

      it 'filters by status' do
        get :index, params: { q: { status_eq: 1 } }
        expect(assigns(:custom_ads)).to include(@advertisement)
      end

      it 'filters by start_at' do
        get :index, params: { q: { start_at_gteq: @advertisement.start_at.strftime(@strftime_1), start_at_lteq: @advertisement.start_at.strftime(@strftime_2) } }
        expect(assigns(:custom_ads)).to include(@advertisement)
      end

      it 'filters by expire_at' do
        get :index, params: { q: { expire_at_gteq: @advertisement.expire_at.strftime(@strftime_1), expire_at_lteq: @advertisement.expire_at.strftime(@strftime_2) } }
        expect(assigns(:custom_ads)).to include(@advertisement)
      end

      it 'filters by created_at' do
        get :index, params: { q: { created_at_gteq: @advertisement.created_at.strftime(@strftime_1), created_at_lteq: @advertisement.created_at.strftime(@strftime_2) } }
        expect(assigns(:custom_ads)).to include(@advertisement)
      end

      it 'filters by updated_at' do
        get :index, params: { q: { updated_at_gteq: @advertisement.updated_at.strftime(@strftime_1), updated_at_lteq: @advertisement.updated_at.strftime(@strftime_2) } }
        expect(assigns(:custom_ads)).to include(@advertisement)
      end
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    context 'with invalid dates' do
      it 'does not allow creation if expire_at is before start_at' do
        advertisement_params = {
          name: 'Advertisement 1',
          description: 'Description 1',
          duration: 25,
          start_at: Time.now,
          expire_at: Time.now - 1.day 
        }

        post :create, params: { advertisement: advertisement_params }
        
        expect(assigns(:custom_ads).errors[:expire_at]).to include('Expiry date should be after the start date')
      end
    end

  end

  describe 'GET show' do
    it 'renders the show template with advertisement details' do
      get :show, params: { id: @advertisement.id }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(@advertisement.name)
      expect(response.body).to include(@advertisement.description)
      expect(response.body).to include(@advertisement.duration)
      expect(response.body).to include(@advertisement.start_at.strftime(@strftime))
      expect(response.body).to include(@advertisement.expire_at.strftime(@strftime))

      expect(response.body).to include(@advertisement.status)
    end
  end
end
