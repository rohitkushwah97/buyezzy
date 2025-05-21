require 'rails_helper'

RSpec.describe BxBlockCatalogue::ParentCataloguesController, type: :controller do

		account = FactoryBot.create(:account)
		token = BuilderJsonWebToken.encode(account.id, token_type: 'login')
		category = FactoryBot.create(:category) 
		brand = FactoryBot.create(:brand) 
		parent_catalogue = FactoryBot.create(:parent_catalogue, category: category,brand: brand  )
		catalogue = FactoryBot.create(:catalogue, category: category, brand: brand, parent_catalogue: parent_catalogue) 

	describe 'get search_parent_catalogues_by_title_or_brand_name' do

		context 'when product and brand are provided' do
			it 'returns matching catalogues for product and brand' do
				get :search_parent_catalogues_by_title_or_brand_name, params: { token: token,product_keyword: parent_catalogue.product_title, brand_keyword: brand.brand_name }
				expect(response).to have_http_status(:ok)
				expect(JSON.parse(response.body)['data'][0]['id']).to eq(parent_catalogue.id.to_s)
			end
		end

		context 'when only product keyword is provided' do
			it 'returns matching catalogues based on the product' do
				get :search_parent_catalogues_by_title_or_brand_name, params: { token: token, brand_keyword: brand.brand_name }
				expect(response).to have_http_status(:ok)
				expect(JSON.parse(response.body)['data'][0]['attributes']['brand']['brand_name']).to include(brand.brand_name)
			end
		end

		context 'when no matching products or brands are found' do
			it 'returns a not found message' do
				post :search_parent_catalogues_by_title_or_brand_name, params: { token: token, product_keyword: 'Product3' }
				expect(response).to have_http_status(:not_found)
				expect(JSON.parse(response.body)['message']).to eq('No products found')
			end
		end
	end

end