require 'rails_helper'

RSpec.describe Admin::BannersController, type: :controller do
	render_views

	let(:admin_user) { create(:admin_user) }

	before do
		BxBlockDashboard::BannerGroup.all.delete_all
		sign_in admin_user
		@category = create(:category) 
		@subcategory = create(:sub_category, category: @category)
		@catalogue = create(:catalogue)
		@deal = create(:deal)
		@banner_group = create(:banner_group, group_name: 'middle_group_2')
		@banner_group2 = create(:banner_group, group_name: 'footer_group_1')
		@banner = create(:banner, category: @category, banner_group: @banner_group2 )
		@banner1 = create(:banner, catalogue: @catalogue )
		@banner2 = create(:banner, sub_category: @subcategory, banner_group: @banner_group )
		@banner3 = create(:banner, deal: @deal)
	end

	describe 'GET #index' do
		it 'renders the index template' do
			get :index
			expect(response).to render_template(:index)
			expect(response).to have_http_status(:ok)
		end

		it 'not to have status 503' do
			get :index

			expect(response.body).not_to include("Service Unavailable")
		end

		it 'assigns @banners' do
			get :index
			expect(assigns(:banners)).to include(@banner)
		end

		context 'with filters' do
			it 'filters by title' do
				get :index, params: { q: { title_cont: @banner.title } }
				expect(assigns(:banners)).to include(@banner)
			end

			it 'filters by description' do
				get :index, params: { q: { description_cont: @banner.description } }
				expect(assigns(:banners)).to include(@banner)
			end

			it 'filters by button_text' do
				get :index, params: { q: { button_text_cont: @banner.button_text } }
				expect(assigns(:banners)).to include(@banner)
			end

			# it 'filters by button_link' do
			# 	get :index, params: { q: { button_link_cont: @banner.button_link } }
			# 	expect(assigns(:banners)).to include(@banner)
			# end

			it 'filters by banner_group_id' do
				get :index, params: { q: { banner_group_id_eq: @banner.banner_group_id } }
				expect(assigns(:banners)).to include(@banner)
			end

			it 'filters by category' do
				get :index, params: { q: { category_id_eq: @banner.category_id } }
				expect(assigns(:banners)).to include(@banner)
			end

			it 'filters by deal' do
				get :index, params: { q: { deal_id_eq: @banner3.deal_id } }
				expect(assigns(:banners)).to include(@banner3)
			end

			it 'filters by sub_category_id' do
				get :index, params: { q: { sub_category_id_eq: @banner2.sub_category_id } }
				expect(assigns(:banners)).to include(@banner2)
			end

			it 'filters by catalogue_id' do
				get :index, params: { q: { catalogue_id_eq: @banner1.catalogue_id } }
				expect(assigns(:banners)).to include(@banner1)
			end

			it 'filters by section' do
				get :index, params: { q: { section_eq: @banner.section } }
				expect(assigns(:banners)).to include(@banner)
			end

			it 'filters by banner_type' do
				get :index, params: { q: { banner_type_eq: 1 } }
				expect(assigns(:banners)).to include(@banner)
			end

			it 'filters by created_at' do
				get :index, params: {
					q: {
						created_at_gteq: @banner.created_at.strftime("%Y-%m-%d 00:00:00"),
						created_at_lteq: @banner.created_at.strftime("%Y-%m-%d 23:59:59")
					}
				}
				expect(assigns(:banners)).to include(@banner)
			end

			it 'filters by updated_at' do
				get :index, params: {
					q: {
						updated_at_gteq: @banner.updated_at.strftime("%Y-%m-%d 00:00:00"),
						updated_at_lteq: @banner.updated_at.strftime("%Y-%m-%d 23:59:59")
					}
				}
				expect(assigns(:banners)).to include(@banner)
			end

		end
	end

	describe 'GET #show' do
		it 'renders the show template' do
			get :show, params: { id: @banner.id }
			expect(response).to render_template(:show)
			expect(assigns(:banners)).to eq(@banner)
		end
	end

	describe 'GET #edit' do
		it 'renders the edit template' do
			get :edit, params: { id: @banner.id }
			expect(response).to render_template(:edit)
		end
	end

end
