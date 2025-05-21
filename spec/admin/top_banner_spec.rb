require 'rails_helper'

RSpec.describe Admin::TopBannersController, type: :controller do
	render_views

	let(:admin_user) { create(:admin_user) }

	before do
		BxBlockDashboard::BannerGroup.all.delete_all
		sign_in admin_user
		@banner = BxBlockDashboard::Banner.find_or_create_by(title: "Free shipping on all UAE orders AED 200", button_text: "SHOP NOW",banner_type: "top_banner", button_link: "https://www.url.com", status: true)
	end

	describe 'GET #index' do
		it 'renders the index template' do
			get :index
			expect(response).to render_template(:index)
			expect(response).to have_http_status(:ok)
		end

		it 'assigns @banners' do
			get :index
			expect(assigns(:top_banners)).to include(@banner)
		end

		context 'with filters' do
			it 'filters by title' do
				get :index, params: { q: { title_cont: @banner.title } }
				expect(assigns(:top_banners)).to include(@banner)
			end

			it 'filters by button_text' do
				get :index, params: { q: { button_text_cont: @banner.button_text } }
				expect(assigns(:top_banners)).to include(@banner)
			end

			it 'filters by button_url' do
				get :index, params: { q: { button_link_cont: @banner.button_link } }
				expect(assigns(:top_banners)).to include(@banner)
			end

			it 'filters by created_at' do
				get :index, params: {
					q: {
						created_at_gteq: @banner.created_at.strftime("%Y-%m-%d 00:00:00"),
						created_at_lteq: @banner.created_at.strftime("%Y-%m-%d 23:59:59")
					}
				}
				expect(assigns(:top_banners)).to include(@banner)
			end

			it 'filters by updated_at' do
				get :index, params: {
					q: {
						updated_at_gteq: @banner.updated_at.strftime("%Y-%m-%d 00:00:00"),
						updated_at_lteq: @banner.updated_at.strftime("%Y-%m-%d 23:59:59")
					}
				}
				expect(assigns(:top_banners)).to include(@banner)
			end

		end
	end

	describe 'GET #show' do
		it 'renders the show template' do
			get :show, params: { id: @banner.id }
			expect(response).to render_template(:show)
			expect(assigns(:top_banner)).to eq(@banner)
		end
	end

	describe 'GET #edit' do
		it 'renders the edit template' do
			get :edit, params: { id: @banner.id }
			expect(response).to render_template(:edit)
		end
	end

end
