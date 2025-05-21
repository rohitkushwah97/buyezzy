require 'rails_helper'

RSpec.describe BxBlockDashboard::GlobalSearchesController, type: :controller do
  before do
    @seller = FactoryBot.create(:account, user_type: 'seller')
    @buyer = FactoryBot.create(:account, user_type: 'buyer')
    @category = FactoryBot.create(:category)
    @custom_field = FactoryBot.create(:custom_field, field_name: 'Old Field Name',fieldable: @category)
    @brand = FactoryBot.create(:brand)
    @subcategory = FactoryBot.create(:sub_category, category: @category)
    @minicategory = FactoryBot.create(:mini_category, sub_category: @subcategory)
    @microcategory = FactoryBot.create(:micro_category, mini_category: @minicategory)
    @catalogue = FactoryBot.create(:catalogue, category: @category, sub_category: @subcategory, mini_category: @minicategory, micro_category: @microcategory, brand: @brand, status: true)
    @product_content = FactoryBot.create(:product_content, catalogue: @catalogue, product_color: "grey", product_title: "stock product")
    @search_keyword_bc = {
      search_keyword: @catalogue.product_content.product_title,
    }
    @blank_keyword = { search_keyword: '' }
    @no_result_keyword = { search_keyword: 'no_result_keyword' }
    @no_result_found = 'No result found'
    @rating = 4
    @reviews = FactoryBot.create_list(:review, 3, reviewer_id: @buyer.id, catalogue: @catalogue, account_id: @seller.id, rating: @rating, review_type: 'product', is_approved: true)
    @low_stock_prod = FactoryBot.create(:catalogue, category: @category,sub_category: @subcategory,mini_category: @minicategory, micro_category: @microcategory, brand: @brand, status: true, seller: @seller, stocks: 0)
    @lsp_product_content = FactoryBot.create(:product_content, catalogue: @low_stock_prod, product_title: "low stock product", product_color: "grey")
    @reviews = FactoryBot.create_list(:review, 3, reviewer_id: @buyer.id, catalogue: @low_stock_prod, account_id: @seller.id, rating: @rating, review_type: 'product', is_approved: true)
    @low_stock_prod2 = FactoryBot.create(:catalogue, category: @category, sub_category: @subcategory, mini_category: @minicategory, micro_category: @microcategory, brand: @brand, stocks: nil, status: true)
    @lsp_product_content2 = FactoryBot.create(:product_content, product_color: "grey", catalogue: @low_stock_prod2, product_title: "low stock product 2")
    @reviews = FactoryBot.create_list(:review, 3, reviewer_id: @buyer.id, catalogue: @low_stock_prod2, account_id: @seller.id, rating: @rating, review_type: 'product', is_approved: true)

    @catalogues = create_list(:catalogue, 6, seller: @seller, category: @category, sub_category: @subcategory, mini_category: @minicategory, micro_category: @microcategory, brand: @brand, status: true)
    @product_content1 = FactoryBot.create(:product_content, catalogue: @catalogues.last, product_color: "grey", product_title: "stock product")
    @trending_product_selections_attributes = @catalogues.map do |catalogue|
      { catalogue_id: catalogue.id }
    end
    @trending_product = create(:trending_product, slider: 1, trending_product_selections_attributes: @trending_product_selections_attributes)
    @trending_slider = {trending_slider: 1}
  end

  describe 'GET #search' do
    context 'with valid search keyword' do
      let(:valid_keyword) do
        {
          "search_keyword": @catalogue.product_content.product_title,
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

      it 'renders search results' do
        get :search, params: valid_keyword
        expect(response).to have_http_status(:ok)
        expect(response_body['message']).to eq('Successfully Loaded')
        expect(response_body['min_range'].to_f).to be_a(Numeric)
        expect(response_body['max_range'].to_f).to be_a(Numeric)
        expect(response_body['total_count']).to be_an(Integer).or eq(nil)

        expect(response_body['data'][2]['attributes']['product_content']['product_attributes']['product_title']).to eq(@catalogue.product_content.product_title)
        expect(response_body['data'][0]['attributes']['status']).to eq(true)
        expect(response_body['data'][2]['attributes']['stocks']).to eq(@catalogue.stocks)
        expect(response_body['data'][1]['attributes']['stocks']).to eq(@low_stock_prod.stocks)
        expect(response_body['data'][0]['attributes']['stocks']).to eq(@low_stock_prod2.stocks)
        expect(response_body['data'][1]['attributes']['product_content']['product_attributes']['product_title']).to eq(@low_stock_prod.product_content.product_title)
        expect(response_body['data'][1]['attributes']['final_price']).to eq(@low_stock_prod.final_price.to_s)
      end

      it 'renders search results with brand name' do
        valid_keyword[:search_keyword] = @catalogue.brand.brand_name
        get :search, params: valid_keyword

        expect(response_body['data'][0]['attributes']['brand']['brand_name']).to eq(@catalogue.brand.brand_name)
      end

      it 'renders search results with category name' do
        valid_keyword[:search_keyword] = @catalogue.category.name
        get :search, params: valid_keyword

        expect(response_body['data'][0]['attributes']['category']['name']).to eq(@catalogue.category.name)
      end

      it 'renders search results with subcategory name' do
        valid_keyword[:search_keyword] = @catalogue.sub_category.name
        get :search, params: valid_keyword

        expect(response_body['data'][0]['attributes']['sub_category']['name']).to eq(@catalogue.sub_category.name)
      end

      it 'renders search results with minicategory name' do
        valid_keyword[:search_keyword] = @catalogue.mini_category.name
        get :search, params: valid_keyword

        expect(response_body['data'][0]['attributes']['mini_category']['name']).to eq(@catalogue.mini_category.name)
      end

      it 'renders search results with microcategory name' do
        valid_keyword[:search_keyword] = @catalogue.micro_category.name
        get :search, params: valid_keyword

        expect(response_body['data'][0]['attributes']['micro_category']['name']).to eq(@catalogue.micro_category.name)
      end

      it 'renders search results with any one filter' do

        valid_keyword[:category_ids] = nil
        valid_keyword[:sub_category_ids] = nil
        valid_keyword[:mini_category_ids] = nil
        valid_keyword[:micro_category_ids] = nil
        valid_keyword[:search_keyword] = @catalogue.brand.brand_name

        get :search, params: valid_keyword

        expect(response_body['data'][0]['attributes']['brand']['id']).to eq(@catalogue.brand.id)
      end

      it 'renders search results with long description' do
        valid_keyword[:search_keyword] = @product_content.long_description
        get :search, params: valid_keyword

        expect(response_body['data']).to be_empty
      end

      it 'filter by product color' do
        post :search, params: valid_keyword

        expect(response).to have_http_status(:ok)
        expect(response_body['data'][0]['attributes']['product_content']['product_attributes']['product_color']).to eq(@catalogue.product_content.product_color)
      end

      it 'filter by out of stocks' do

        valid_keyword_1 = { search_keyword: @low_stock_prod2.product_content.product_title, out_of_stocks: true }

        post :search, params: valid_keyword_1

        expect(response).to have_http_status(:ok)
        expect(response_body['data'][0]['attributes']['stocks']).to eq(@low_stock_prod2.stocks)
      end

      it 'filters products by custom field values' do
        custom_field_values = ['value1', 'value2']
        catalogue_content1 = FactoryBot.create(:catalogue_content, catalogue: @catalogue, custom_field: @custom_field, value: custom_field_values.first)
        catalogue_content2 = FactoryBot.create(:catalogue_content, catalogue: @catalogue, custom_field: @custom_field, value: custom_field_values.second)

        post :search, params: { search_keyword: @catalogue.product_content.product_title, custom_field_values: custom_field_values }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data'].map { |item| item['id'] }).to include(@catalogue.id.to_s)
      end
    end

    context 'with blank search keyword' do

      it 'renders no product found' do
        get :search, params: @blank_keyword 
        expect(response).to have_http_status(:not_found)
        expect(response_body['message']).to eq('No products found')
      end
    end

    context 'when no results match' do
      it 'returns empty products list' do
        get :search, params: @no_result_keyword
        expect(response).to have_http_status(:ok)
        expect(response_body['data']).to be_empty
      end
    end
  end

  describe 'GET #brands_filter_lists' do
    context 'with valid search keyword for brands list' do

      it 'renders brands filter list' do
        get :brands_filter_lists, params: @search_keyword_bc
        expect(response).to have_http_status(:ok)
        expect(response_body['data'][0]['type']).to eq('brand')
      end

      it 'renders brands filter list by trending slider' do
        get :brands_filter_lists, params: @trending_slider
        expect(response).to have_http_status(:ok)
        expect(response_body['data'][0]['id']).to eq(@catalogues.last.brand.id.to_s)
      end
    end

    context 'with blank search keyword brands_filter_lists' do
      it 'renders no result found brands_filter_lists' do
        get :brands_filter_lists, params: @blank_keyword
        expect(response).to have_http_status(:not_found)
        expect(response_body['message']).to eq(@no_result_found)
      end

      it 'renders no result found brands_filter_lists by keyword' do
        get :brands_filter_lists, params: @no_result_keyword
        expect(response).to have_http_status(:not_found)
        expect(response_body['message']).to eq(@no_result_found)
      end
    end
  end

  describe 'GET #categories_filter_lists' do
    context 'with valid search keyword for category list' do

      it 'renders categories filter list' do
        get :categories_filter_lists, params: @search_keyword_bc
        expect(response).to have_http_status(:ok)
        expect(response_body['data'].last['type']).to eq('category')
      end

      it 'renders categories filter list by trending slider' do
        get :categories_filter_lists, params: @trending_slider
        expect(response).to have_http_status(:ok)
        expect(response_body['data'][0]['id']).to eq(@catalogues.last.category.id.to_s)
      end
    end

    context 'with blank search keyword categories_filter_lists' do
      it 'renders no result found categories_filter_lists' do
        get :categories_filter_lists, params: @blank_keyword
        expect(response).to have_http_status(:not_found)
        expect(response_body['message']).to eq(@no_result_found)
      end

      it 'renders no result found categories_filter_lists keyword' do
        get :categories_filter_lists, params: @no_result_keyword
        expect(response).to have_http_status(:not_found)
        expect(response_body['message']).to eq(@no_result_found)
      end
    end
  end

  def response_body
    JSON.parse(response.body)
  end
end
