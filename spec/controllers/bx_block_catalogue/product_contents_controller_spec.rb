require 'rails_helper'

RSpec.describe BxBlockCatalogue::ProductContentsController, type: :controller do

  before do
    @account = FactoryBot.create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @category = FactoryBot.create(:category)
    @sub_category = FactoryBot.create(:sub_category)
    @mini_category = FactoryBot.create(:mini_category)
    @micro_category = FactoryBot.create(:micro_category)

    @custom_field1 = FactoryBot.create(:custom_field, field_name: 'Field1', fieldable: @category)
    @custom_field2 = FactoryBot.create(:custom_field, field_name: 'Field2', fieldable: @sub_category)
    @custom_field3 = FactoryBot.create(:custom_field, field_name: 'Field3', fieldable: @mini_category)
    @custom_field4 = FactoryBot.create(:custom_field, field_name: 'Field4', fieldable: @micro_category)

    @catalogue = create(:catalogue, category: @category, sub_category: @sub_category, mini_category: @mini_category, micro_category: @micro_category)
    @catalogue_content = @catalogue.catalogue_contents.last

    @product_content = create(:product_content, catalogue: @catalogue)
    @image_urls = create_list(:image_url,2, product_content: @product_content)
    @image_urls = create_list(:image_url,2, product_content: @product_content)

    @deal = create(:deal, status: true)
    @deal_catalogue = create(:deal_catalogue, deal: @deal, catalogue: @catalogue, seller: @account)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: { catalogue_id: @catalogue.id, token: @token }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        "data": {
          "attributes": {
            "gtin": Faker::Number.number(digits: 9),
            "unique_psku": @catalogue.sku,
            "brand_name": "Brand Name",
            "product_title": "Product Title",
            "mrp": 150.00,
            "retail_price": 129.99,
            "long_description": "Product long description",
            "whats_in_the_package": "Package content",
            "country_of_origin": "India",
            "product_color": "Grey",
            "dispenser_type": "Type",
            "scent_type": "Scent",
            "target_use": "Target use",
            "style_name": "Style Name",
            "size_and_capacity_attributes": {
              "size": 2,
              "size_unit": "Millimeter",
              "hs_code": "123475",
              "prod_model_name": "XYZ",  
              "capacity": 3,
              "capacity_unit": "Millilitre",
              "prod_model_number": "123ABC123", 
              "number_of_pieces": 10
            },
            "shipping_detail_attributes": {
              "shipping_length": 5,
              "shipping_length_unit": "Gram",
              "shipping_height": 3,
              "shipping_height_unit": "Gram",
              "shipping_width": 2,
              "shipping_width_unit": "Gram",
              "shipping_weight": 1.5,
              "shipping_weight_unit": "Kilogram"
            },
            "image_urls_attributes": [
              {
                "url": "https://example.com/image1.jpg"
              },
              {
                "url": "https://example.com/image2.jpg"
              }
            ],
            "feature_bullets_attributes": [
              {
                "field_name": "feature_bullet_1",
                "value": "Bullet 1"
              },
              {
                "field_name": "feature_bullet_2",
                "value": "Bullet 2"
              }
            ],
            "special_features_attributes": [
              {
                "field_name": "special_feature_1",
                "value": "Special Feature 1"
              },
              {
                "field_name": "special_feature_2",
                "value": "Special Feature 2"
              }
            ],
            catalogue_content_attributes: [
              {
                id: @catalogue_content.id,
                value: "Updated Value"
              }
            ]
          }
        }
      }
    end

    it 'creates a new ProductContent' do
      post :create, params: valid_params.merge(catalogue_id: @catalogue.id, token: @token)
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['data']['attributes']['brand_name']).to eq("Brand Name")
    end

    it 'updates the catalogue content' do
      post :create, params: valid_params.merge(catalogue_id: @catalogue.id, token: @token)
      @catalogue_content.reload
      expect(@catalogue_content.value).to eq("Updated Value")
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH #update' do
    let(:valid_params) do
      {
        data: {
          attributes: {
            retail_price: 199.99,
            "image_urls_attributes": [
              {
                id: @product_content.image_urls.first.id,
                "url": "https://example.com/image3.jpg"
              },
              {
                id: @product_content.image_urls.last.id,
                "url": "https://example.com/image4.jpg",
                _destroy: true
              }
            ]
          }
        }
      }
    end

    let(:mer_param) do
      { catalogue_id: @catalogue.id, id: @product_content.id, token: @token }
    end

    it 'updates the update_associated_content' do
      patch :update, params: valid_params.merge(mer_param)
      @product_content.reload
      expect(@product_content.retail_price).to eq(valid_params[:data][:attributes][:retail_price])
      expect(@deal_catalogue.reload.seller_price).to eq(valid_params[:data][:attributes][:retail_price])
      expect(response).to be_successful
    end

    it 'delete the requested product_content' do
      patch :update, params: valid_params.merge(mer_param)
      @product_content.reload
      expect(@product_content.image_urls.count).to eq(4)
      # expect(response).to be_successful
    end

  end

  describe 'Error response' do
    it 'returns the correct error messages for blank fields' do
      post :create, params: {
        data: {
          attributes: {
            gtin: @product_content.gtin,
            unique_psku: @product_content.unique_psku,
            brand_name: '',
            product_title: '',
            mrp: 150.00,
            retail_price: 129.99
          }
        },
        catalogue_id: @catalogue.id,
        token: @token
      }
      response_body = JSON.parse(response.body)
      expect(response_body['errors']).to match_array([
        "Brand name can't be blank",
        "Product title can't be blank"
      ])
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns the correct error messages for existing product' do
      @catalogue_2 = create(:catalogue) 
      @product_content_2 = create(:product_content, catalogue: @catalogue_2)
      post :update, params: {
        data: {
          attributes: {
            gtin: @product_content.gtin,
            unique_psku: @product_content.unique_psku,
            brand_name: 'Brand',
            product_title: 'Title',
            mrp: 150.00,
            retail_price: 129.99
          }
        },
        catalogue_id: @catalogue_2.id,
        token: @token,
        id: @product_content_2.id
      }
      response_body = JSON.parse(response.body)
      expect(response_body['errors']).to match_array([
        "Gtin has already been taken",
        "Unique psku must match the SKU of the associated catalogue"
      ])
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
