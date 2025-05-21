require 'rails_helper'

RSpec.describe Admin::SocialPlatformsController, type: :controller do
	render_views

	before do
		@admin = FactoryBot.create(:admin_user)
		sign_in @admin
		@social_platform = create(:social_platform)
	end

	describe 'GET index' do
		it 'renders the index template' do
			get :index
			expect(response).to render_template(:index)
			expect(response.body).to include(@social_platform.social_media)
			expect(response.body).to include(@social_platform.social_media_url)
		end 
	end

	describe 'GET show' do

		it 'renders the show template' do
			get :show, params: { id: @social_platform.id }
			expect(response).to render_template(:show)
			expect(assigns(:social_platforms)).to eq(@social_platform)
			expect(Rails.application.routes.url_helpers.rails_blob_path(assigns(:social_platforms).social_icon, only_path: true)).to include(Rails.application.routes.url_helpers.rails_blob_path(@social_platform.social_icon, only_path: true))
		end

	end

	describe "GET #edit" do
		it "returns a successful response" do
			get :edit, params: { id: @social_platform.id }
			expect(response).to render_template(:edit)
		end
	end
end