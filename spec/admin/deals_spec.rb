require 'rails_helper'

RSpec.describe Admin::DealsController, type: :controller do
	render_views
	let(:admin_user) { create(:admin_user) }
	let(:account) {create(:account, user_type: 'seller')}
	let!(:deal) { create(:deal) }
	let!(:catalogue) { create(:catalogue) }
	let!(:deal_catalogue) { create(:deal_catalogue, deal: deal, catalogue: catalogue , seller: account) }

	before do
		sign_in admin_user
	end

	describe 'GET #index' do
		it 'displays the list of deals' do
			get :index

			expect(response).to have_http_status(:ok)
			expect(response).to render_template(:index)
			expect(response.body).to include(deal.deal_name)
			expect(response.body).to include(deal.deal_code)
			expect(response.body).to include(deal.discount_type)
			expect(response.body).to include(deal.discount_value.to_s)
		end
	end

	describe 'GET #show' do
		it 'displays deal details and related deal catalogues' do

			get :show, params: { id: deal.id }

			expect(response).to have_http_status(:ok)
			expect(response.body).to include(deal.deal_name)
			expect(response.body).to include(deal.deal_code)
			expect(response.body).to include(deal_catalogue.seller_sku)
			# expect(response.body).to include(deal_catalogue.product_title)
			expect(response.body).to include(deal_catalogue.deal_price.to_s)
			expect(response.body).to include(deal_catalogue.status.capitalize)
			expect(response.body).to include('Edit Status')
			expect(response.body).to include("Deal Catalogues")
		end
	end

	describe 'filters' do
		it 'filters by deal name' do
			get :index, params: { q: { deal_name_eq: deal.deal_name } }
			expect(assigns(:deals)).to include(deal)
		end

		it 'filters by deal code' do
			get :index, params: { q: { deal_code_eq: deal.deal_code } }
			expect(assigns(:deals)).to include(deal)
		end

		it 'filters by start date' do
			get :index, params: { q: { start_date_eq: deal.start_date } }
			expect(assigns(:deals)).to include(deal)
		end

		it 'filters by end date' do
			get :index, params: { q: { end_date_eq: deal.end_date } }
			expect(assigns(:deals)).to include(deal)
		end

		it 'filters by status' do
			get :index, params: { q: { status_eq: deal.status } }
			expect(assigns(:deals)).to include(deal)
		end

		it 'filters by created_at' do
			get :index, params: { q: { created_at_gteq_datetime: deal.created_at.strftime('%Y-%m-%d 00:00:00'), created_at_lteq_datetime: deal.created_at.strftime('%Y-%m-%d 23:59:59') } }
			expect(assigns(:deals)).to include(deal)
		end

		it 'filters by updated_at' do
			get :index, params: { q: { updated_at_gteq_datetime: deal.updated_at.strftime('%Y-%m-%d 00:00:00'), updated_at_lteq_datetime: deal.updated_at.strftime('%Y-%m-%d 23:59:59') } }
			expect(assigns(:deals)).to include(deal)
		end
	end

	describe "GET new" do
		it "displays the new deal form" do
			get :new
			expect(response).to have_http_status(:success)
			expect(response).to render_template(:new)
		end
	end
end