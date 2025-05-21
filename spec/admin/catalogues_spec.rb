require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
	render_views

	let(:admin_user) { create(:admin_user) }
	let(:account) {create(:account, user_type: 'seller')}
	let(:category) { create(:category) }
	let(:subcategory) {create(:sub_category, category: category) }
	let(:minicategory) { create(:mini_category, sub_category: subcategory) }
	let(:microcategory) { create(:micro_category,mini_category: minicategory) }
	let!(:catalogue) { create(:catalogue, product_image: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "Sample.jpg")), category: category,sub_category: subcategory,mini_category: minicategory, micro_category: microcategory, seller: account) }
	let!(:product_content) {create(:product_content, catalogue: catalogue)}
	let!(:deal) { create(:deal) }
	let!(:deal_catalogue) { create(:deal_catalogue, deal: deal, catalogue: catalogue,seller: account) }
	let(:barcode) { create(:barcode, catalogue: catalogue) }
	let(:catalogue_offer) { create(:catalogue_offer, catalogue: catalogue, barcode: barcode) }
	let!(:archived_catalogue) { create(:catalogue, content_status: 'archived', category: category, sub_category: subcategory, mini_category: minicategory, micro_category: microcategory) }


	before do
		sign_in admin_user
	end

	describe 'GET #index' do
		it 'returns a success index response' do
			get :index
			expect(response).to be_successful
		end

		it 'displays catalogue data in response body' do
			get :index
			expect(response.body).to include(catalogue.sku)
			expect(response.body).to include(catalogue.product_title)
		end

		context 'with filters' do
			it 'filters by category' do
				get :index, params: { q: { category_id_eq: catalogue.category_id } }
				expect(assigns(:products).last.category_id).to eq(catalogue.category_id)
			end

			it 'filters by brand' do
				get :index, params: { q: { brand_id_eq: catalogue.brand_id } }
				expect(assigns(:products).last.brand_id).to eq(catalogue.brand_id)
			end

			it 'filters by sub-category' do
				get :index, params: { q: { sub_category_id_eq: catalogue.sub_category_id } }
				expect(assigns(:products).last.sub_category_id).to eq(catalogue.sub_category.id)
			end

			it 'filters by mini-category' do
				get :index, params: { q: { mini_category_id_eq: catalogue.mini_category_id } }
				expect(assigns(:products).last.mini_category_id).to eq(catalogue.mini_category.id)
			end

			it 'filters by micro-category' do
				get :index, params: { q: { micro_category_id_eq: catalogue.micro_category_id } }
				expect(assigns(:products).last.micro_category_id).to eq(catalogue.micro_category.id)
			end

			it 'filters by deal catalogues' do
				get :index, params: { q: { deal_catalogues_id_eq: deal_catalogue.id } }
				expect(assigns(:products).last.deal_catalogues.first.id).to eq(deal_catalogue.id)
			end

			it 'filters by catalogue offer' do
				get :index, params: { q: { catalogue_offer_id_eq: catalogue_offer.id } }
				expect(assigns(:products).last.catalogue_offer.id).to eq(catalogue_offer.id)
			end

			it 'filters by barcode' do
				get :index, params: { q: { barcode_id_eq: barcode.id } }
				expect(assigns(:products).last.barcode.id).to eq(barcode.id)
			end

			it 'filters by SKU' do
				get :index, params: { q: { sku_or_product_variant_group_product_sku_cont: catalogue.sku } }
				expect(assigns(:products).last.sku).to include(catalogue.sku)
			end

			it 'filters by BESKU' do
				get :index, params: { q: { besku_or_product_variant_group_product_besku_cont: catalogue.besku } }
				expect(assigns(:products).last.besku).to include(catalogue.besku)
			end

			it 'filters by product title' do
				get :index, params: { q: { product_title_cont: catalogue.product_title } }
				expect(assigns(:products).last.product_title).to include(catalogue.product_title)
			end

			it 'filters by status' do
				get :index, params: { q: { status_eq: catalogue.status } }
				expect(assigns(:products).last.status).to eq(catalogue.status)
			end

			it 'filters by created_at' do
				get :index, params: { q: { created_at_gteq_datetime: catalogue.created_at.strftime("%Y-%m-%d 00:00:00"), created_at_lteq_datetime: catalogue.created_at.strftime("%Y-%m-%d 23:59:59") } }
				expect(assigns(:products).last.created_at.to_date.to_s).to eq(catalogue.created_at.to_date.to_s)
			end

			it 'filters by updated_at' do
				get :index, params: { q: { updated_at_gteq_datetime: catalogue.updated_at.strftime("%Y-%m-%d 00:00:00"), updated_at_lteq_datetime: catalogue.updated_at.strftime("%Y-%m-%d 23:59:59") } }
				expect(assigns(:products).last.updated_at.to_date.to_s).to eq(catalogue.updated_at.to_date.to_s)
			end

		end
	end

	describe 'PUT #archive' do
		it 'archives the catalogue item' do
			put :archive, params: {id: catalogue.id }
			expect(response).to redirect_to(admin_products_path)
			catalogue.reload
			expect(catalogue.content_status).to eq('archived')
		end
	end

	describe 'PUT #unarchives' do
		before do
			catalogue.update(content_status: 'archived')
		end

		it 'unarchives the catalogue item' do
			put :unarchive, params: {id: catalogue.id}
			expect(response).to redirect_to(admin_products_path)
			catalogue.reload
			expect(catalogue.content_status).to eq('under_review')
		end
	end

	describe 'Scopes' do
		it 'includes non-archived catalogues in the default scope' do
			get :index
			expect(assigns(:products)).to include(catalogue)
		end

		it 'includes only archived catalogues in the archived scope' do
			catalogue.update(content_status: 'archived')
			get :index, params: {scope: 'archived'}
			expect(assigns(:products)).to include(catalogue)
		end
	end

	describe 'GET #show' do
		it 'returns a success show response' do
			get :show, params: { id: catalogue.id }
			expect(response).to be_successful
		end

		it 'returns a success show response' do
			variant = create(:catalogue, product_image: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "Sample.jpg")), category: category,sub_category: subcategory,mini_category: minicategory, micro_category: microcategory, is_variant: true, parent_product: catalogue)
			get :show, params: { id: variant.id }
			expect(response).to be_successful
			expect(response.body).to include('Parent Product')

		end

		it 'shows the Unarchive link' do
			get :show, params: { id: archived_catalogue.id }
			expect(response.body).to include('Unarchive')
		end

		it 'displays catalogue details in response body' do
			content = create(:catalogue_content, catalogue: catalogue)
			offer = create(:catalogue_offer, catalogue: catalogue)
			code = create(:barcode, catalogue: catalogue)
			get :show, params: { id: catalogue.id }
			expect(response.body).to include(catalogue.sku)
			expect(response.body).to include(catalogue.product_title)
			expect(response.body).to include(deal_catalogue.deal.deal_name)
			expect(response.body).to include(product_content.product_title)
			expect(response.body).to include(product_content.whats_in_the_package)
			expect(response.body).to include('Edit')
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
			get :edit, params: { id: catalogue.id }
			expect(response).to be_successful
			expect(response.body).to include(Rails.application.routes.url_helpers.rails_blob_path(catalogue.product_image, only_path: true))
		end
	end

	describe 'PATCH #update' do
		it 'returns a success update response via email #accepted' do
			catalogue.update(content_status: 'under_review')
			patch :update, params: { id: catalogue.id, catalogue: { content_status: "accepted", status: true } }

			expect(ActionMailer::Base.deliveries.count).to eq(1)
		end

		it 'returns a success update response via email #rejected' do
			catalogue.update(content_status: 'under_review')
			patch :update, params: { id: catalogue.id, catalogue: { content_status: "rejected" } }

			expect(ActionMailer::Base.deliveries.count).to eq(1)
		end
	end

	describe 'validations' do
		let(:product_image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/document.pdf'), 'text/pdf') }
		let(:catalogue1) { build(:catalogue, product_image: product_image) }

		context 'with an invalid image type' do
			it 'is not valid' do
				expect(catalogue1).not_to be_valid
				expect(catalogue1.errors[:product_image]).to include('must be a JPEG/JPG/PNG/WebP file')
			end
		end
	end

end
