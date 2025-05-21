require 'rails_helper'

RSpec.describe BxBlockDashboard::TrendingProductsController, type: :controller do

  before do
    @seller = create(:account, user_type: 'seller')
    @buyer = FactoryBot.create(:account, user_type: 'buyer')
    @category = FactoryBot.create(:category)
    @custom_field = FactoryBot.create(:custom_field, field_name: 'Old Field Name',fieldable: @category)
    @brand = FactoryBot.create(:brand)
    @subcategory = FactoryBot.create(:sub_category, category: @category)
    @minicategory = FactoryBot.create(:mini_category, sub_category: @subcategory)
    @microcategory = FactoryBot.create(:micro_category, mini_category: @minicategory)

    @catalogues = create_list(:catalogue, 6, seller: @seller, category: @category, sub_category: @subcategory, mini_category: @minicategory, micro_category: @microcategory, brand: @brand, status: true)
    @product_content = FactoryBot.create(:product_content, catalogue: @catalogues.last, product_color: "grey", product_title: "stock product")
    @trending_product_selections_attributes = @catalogues.map do |catalogue|
      { catalogue_id: catalogue.id }
    end
    @trending_product = create(:trending_product, slider: 1, trending_product_selections_attributes: @trending_product_selections_attributes)
    @catalogues.second.update(stocks: 0)
    @product_content = FactoryBot.create(:product_content, catalogue: @catalogues.second, product_color: "grey", product_title: "low stock product")

    @rating = 4
    @reviews1 = FactoryBot.create_list(:review, 3, reviewer_id: @buyer.id, catalogue: @catalogues.last, account_id: @seller.id, rating: @rating, review_type: 'product', is_approved: true)
    @reviews2 = FactoryBot.create_list(:review, 3, reviewer_id: @buyer.id, catalogue: @catalogues.second, account_id: @seller.id, rating: @rating, review_type: 'product', is_approved: true)
  end
  
  describe 'GET #index' do
    it 'returns a successful response with a list of slider' do
      get :index

      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data'].length).to eq(BxBlockDashboard::TrendingProduct.all.count)
    end

    it 'returns a successful response with a list of slider filter' do
      trending_product_inx = create(:trending_product, slider: 'slider_2', trending_product_selections_attributes: @trending_product_selections_attributes)
      get :index, params: {slider: 2}

      parsed_response_1 = JSON.parse(response.body)
      expect(parsed_response_1['data'][0]['attributes']['slider']).to eq(trending_product_inx.slider)
    end
  end

  describe 'GET #show' do

    it 'returns a successful response with the details of a slider' do
      get :show, params: { id: @trending_product.id }

      expect(response).to have_http_status(:success)
      parsed_response_2 = JSON.parse(response.body)
      expect(parsed_response_2['data']['id']).to eq(@trending_product.id.to_s)
    end
  end

  describe 'GET #list_trending_products' do
    context 'with valid slider keyword' do
      let(:valid_keyword) do
        {
          "slider": 1,
          "per_page": 50,
          "page": 1,
          "category_ids": [@category.id],
          "sub_category_ids": [@subcategory.id],
          "mini_category_ids": [@minicategory.id],
          "micro_category_ids": [@microcategory.id],
          "brand_ids": [@brand.id],
          "min_price": 10,
          "max_price": 500,
          "sort_by": "whats_new",
          "filter_by_rating": [@rating],
          "color_filter": ["grey"],
          "out_of_stocks": false
        }
      end

      it 'renders slider results' do
        post :list_trending_products, params: valid_keyword

        expect(response_body['min_range'].to_f).to be_a(Numeric)
        expect(response_body['max_range'].to_f).to be_a(Numeric)
        expect(response_body['total_count']).to be_an(Integer).or eq(nil)

        expect(response_body['data'][0]['attributes']['product_content']['product_attributes']['product_title']).to eq(@catalogues.last.product_content.product_title)
        expect(response_body['data'][0]['attributes']['status']).to eq(true)
        expect(response_body['data'][0]['attributes']['stocks']).to eq(@catalogues.last.stocks)
        expect(response_body['data'][0]['attributes']['final_price']).to eq(@catalogues.last.final_price.to_s)
      end

      it 'filter by product color' do
        post :list_trending_products, params: valid_keyword

        expect(response_body['data'][0]['attributes']['product_content']['product_attributes']['product_color']).to eq(@catalogues.last.product_content.product_color)
      end

      it 'filter by out of stocks' do

        valid_keyword[:out_of_stocks] = true

        post :list_trending_products, params: valid_keyword

        expect(response_body['data'][0]['attributes']['stocks']).to eq(@catalogues.second.stocks)
      end

      it 'filters products by custom field values' do
        custom_field_values = ['value1', 'value2']
        catalogue_content1 = FactoryBot.create(:catalogue_content, catalogue: @catalogues.last, custom_field: @custom_field, value: custom_field_values.first)
        catalogue_content2 = FactoryBot.create(:catalogue_content, catalogue: @catalogues.last, custom_field: @custom_field, value: custom_field_values.second)

        post :list_trending_products, params: { slider: 1, custom_field_values: custom_field_values }

        expect(JSON.parse(response.body)['data'].map { |item| item['id'] }).to include(@catalogues.last.id.to_s)
      end
    end

    context 'with blank slider' do

      it 'renders missing slider' do
        post :list_trending_products, params: {}
        expect(response_body['message']).to eq("missing slider in params")
      end
    end

     context 'with invalid slider' do

      it 'renders missing trending product' do
        post :list_trending_products, params: {slider: 2}
        expect(response_body['message']).to eq("No trending products found for the given slider")
      end
    end
  end

  private

  def response_body
    JSON.parse(response.body)
  end
end
