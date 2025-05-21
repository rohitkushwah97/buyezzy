require 'rails_helper'

RSpec.describe Admin::SellerDealsController, type: :controller do
	render_views
	let(:admin_user) { create(:admin_user) }
	let(:account) {create(:account, user_type: 'seller')}
	let!(:deal) { create(:deal) }
	let!(:catalogue) { create(:catalogue) }
	let!(:deal_catalogue) { create(:deal_catalogue, deal: deal, catalogue: catalogue,seller: account, status: 0 ) }

	before do
		sign_in admin_user
	end

	describe 'GET #show' do
		it 'displays deal catalogue details' do
			get :show, params: { id: deal_catalogue.id }

			expect(response).to have_http_status(:ok)
			expect(response.body).to include(deal.deal_name)
			expect(response.body).to include(catalogue.sku)
			expect(response.body).to include(deal_catalogue.status) 
			expect(response.body).to include(deal_catalogue.deal_price.to_s)
			expect(response.body).to include(deal_catalogue.created_at.strftime('%B %d, %Y %H:%M'))
			expect(response.body).to include(deal_catalogue.updated_at.strftime('%B %d, %Y %H:%M'))

		end
	end


	describe 'GET #index' do
		it 'displays the list of deal catalogues' do
			get :index

			expect(response).to have_http_status(:ok)
			expect(response.body).to include(deal.deal_name)
			expect(response.body).to include(catalogue.sku)
			expect(response.body).to include(deal_catalogue.status)
			expect(response.body).to include(deal_catalogue.deal_price.to_s)
		end

		it 'filters by deal name' do
			get :index, params: { q: { deal_id_eq: deal.id } }
			expect(assigns(:seller_deals)).to include(deal_catalogue)
		end

		it 'filters by catalogue SKU' do
			get :index, params: { q: { catalogue_sku_contains: catalogue.sku } }
			expect(assigns(:seller_deals)).to include(deal_catalogue)
		end

		it 'filters by status' do
			get :index, params: { q: { status_eq: deal_catalogue.status } }
			expect(assigns(:seller_deals)).to include(deal_catalogue)
		end

		it 'filters by deal price' do
			get :index, params: { q: { deal_price_eq: deal_catalogue.deal_price } }
			expect(assigns(:seller_deals)).to include(deal_catalogue)
		end

		it 'filters by created_at' do
			get :index, params: { q: { created_at_gteq_datetime: deal_catalogue.created_at.strftime('%Y-%m-%d 00:00:00'), created_at_lteq_datetime: deal_catalogue.created_at.strftime('%Y-%m-%d 23:59:59') } }
			expect(assigns(:seller_deals)).to include(deal_catalogue)
		end

		it 'filters by updated_at' do
			get :index, params: { q: { updated_at_gteq_datetime: deal_catalogue.updated_at.strftime('%Y-%m-%d 00:00:00'), updated_at_lteq_datetime: deal_catalogue.updated_at.strftime('%Y-%m-%d 23:59:59') } }
			expect(assigns(:seller_deals)).to include(deal_catalogue)
		end
	end

	describe 'GET #edit' do
		it 'displays the edit form for a deal catalogue' do
			get :edit, params: { id: deal_catalogue.id }

			expect(response).to have_http_status(:ok)
			expect(response.body).to include('Edit Seller Deal')
			expect(response.body).to include(deal_catalogue.status)
			expect(response.body).to include(deal_catalogue.deal_price.to_s)
		end
	end

	describe 'PUT #update' do
		it 'updates the deal catalogue status and redirects back to the deal show page' do
			new_status = 'approved'

			put :update, params: { id: deal_catalogue.id, 'deal_catalogue' => { 'status' => new_status, deal_id: deal.id } }

			expect(response).to redirect_to(admin_deal_path(deal))
			expect(deal_catalogue.reload.status).to eq(new_status)
		end
	end

	describe 'PUT #update' do
	  it 'updates the deal catalogue status and redirects back to the deal show page' do
	    new_status = 'review'
	    new_deal_price = 150.0

	    put :update, params: {
	      id: deal_catalogue.id,
	      deal_catalogue: {
	        status: new_status,
	        seller_id: account.id,
	        deal_id: deal.id,
	        deal_price: new_deal_price
	      }
	    }

	    expect(response).to redirect_to(admin_deal_path(deal))
	    expect(deal_catalogue.reload.status).to eq('review')
	    expect(deal_catalogue.reload.seller_id).to eq(account.id)
	    expect(deal_catalogue.reload.deal_price).to eq(new_deal_price)
	  end
	end
end