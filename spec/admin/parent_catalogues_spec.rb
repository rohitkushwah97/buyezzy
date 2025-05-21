require 'rails_helper'

RSpec.describe Admin::ByezzyProductsController, type: :controller do
	render_views

	let(:admin_user) { create(:admin_user) }
	let(:category) { create(:category) }
	let(:seller) { create(:account, user_type: 'seller') }
	let(:parent_catalogue) {create(:parent_catalogue)}
	let!(:catalogue) { create(:catalogue, product_image: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "Sample.jpg")), category: category, seller: seller, parent_catalogue: parent_catalogue) }

	before do
		sign_in admin_user
	end

	describe 'GET #index' do
		it 'returns a success index response' do
			get :index
			expect(response).to be_successful
		end

		it 'displays parent catalogue data in response body' do
			parent_catalogue_i = create(:parent_catalogue,product_title: "test prod" )
			get :index
			expect(response.body).to include(parent_catalogue_i.sku)
			expect(response.body).to include(parent_catalogue_i.product_title)
		end

		context 'with filters' do
			it 'filters by category' do
				get :index, params: { q: { category_id_eq: parent_catalogue.category_id } }
				expect(assigns(:byezzy_products).last.category_id).to eq(parent_catalogue.category_id)
			end

			it 'filters by brand' do
				get :index, params: { q: { brand_id_eq: parent_catalogue.brand_id } }
				expect(assigns(:byezzy_products).last.brand_id).to eq(parent_catalogue.brand_id)
			end

			it 'filters by BESKU' do
				get :index, params: { q: { besku_cont: parent_catalogue.besku } }
				expect(assigns(:byezzy_products).last.besku).to include(parent_catalogue.besku)
			end

			it 'filters by product title' do
				get :index, params: { q: { product_title_cont: parent_catalogue.product_title } }
				expect(assigns(:byezzy_products).last.product_title).to include(parent_catalogue.product_title)
			end

			it 'filters by status' do
				get :index, params: { q: { status_eq: parent_catalogue.status } }
				expect(assigns(:byezzy_products).last.status).to eq(parent_catalogue.status)
			end

		end
	end

	describe 'GET #show' do
		it 'returns a success show response' do
			get :show, params: { id: parent_catalogue.id }
			expect(response).to be_successful
		end

		it 'displays parent_catalogue details in response body' do
			get :show, params: { id: parent_catalogue.id }
			expect(response.body).to include(parent_catalogue.besku)
			expect(response.body).to include(parent_catalogue.product_title)
			expect(response.body).to include(catalogue.sku)
			expect(response.body).to include(catalogue.seller.full_name)
		end
	end

	describe 'GET #new' do
		it 'returns a success new response' do
			get :new
			expect(response).to be_successful
		end
	end

	describe 'GET #edit' do
		it 'returns a success update response' do
			get :edit, params: { id: parent_catalogue.id }
			expect(response).to be_successful
			expect(response.body).to include(Rails.application.routes.url_helpers.rails_blob_path(parent_catalogue.product_image, only_path: true))
		end
	end

	# describe 'PATCH #update' do
	# 	it 'returns an unsuccessful update response with validation message' do
	# 		patch :update, params: { id: parent_catalogue.id, parent_catalogue: { prod_model_no: 'ajhj' } }


	# 		expect(flash[:error]).to include("should be uppercase alphanumeric and have a length between 5 and 13 characters")
	# 	end
	# end


end
