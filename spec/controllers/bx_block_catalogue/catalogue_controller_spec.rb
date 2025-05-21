require 'rails_helper'

RSpec.describe BxBlockCatalogue::CataloguesController, type: :controller do

  before do
    sample_image_path = Rails.root.join('spec', 'fixtures', 'files', 'Sample.jpg')
    sample_image = File.open(sample_image_path, 'rb').read
    stub_request(:get, "https://fastly.picsum.photos/id/20/3670/2462.jpg?hmac=CmQ0ln-k5ZqkdtLvVO23LjVAEabZQx2wOaT4pyeG10I").
    with(
     headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby',
    }).
    to_return(status: 200, body: sample_image, headers: {'Content-Type' => 'image/jpeg'})
  end

  account = FactoryBot.create(:account, user_type: "seller") 
  seller2 = FactoryBot.create(:account, user_type: "seller") 
  buyer = FactoryBot.create(:account, user_type: "buyer")
  token = BuilderJsonWebToken.encode(account.id, token_type: 'login')  
  category = FactoryBot.create(:category) 
  custom_field = FactoryBot.create(:custom_field, field_name: 'Old Field Name',fieldable: category)
  brand = FactoryBot.create(:brand) 
  restricted_brand = FactoryBot.create(:brand, restricted: true) 
  subcategory = FactoryBot.create(:sub_category, category: category) 
  minicategory = FactoryBot.create(:mini_category, sub_category: subcategory) 
  microcategory = FactoryBot.create(:micro_category,mini_category: minicategory)
  microcategory_2 = FactoryBot.create(:micro_category,mini_category: minicategory)
  custom_field_2 = FactoryBot.create(:custom_field, field_name: 'mandatory',fieldable: microcategory_2, mandatory: true)
  parent_catalogue = FactoryBot.create(:parent_catalogue, category: category, brand: brand, status: true) 
  catalogue = FactoryBot.create(:catalogue, parent_catalogue: parent_catalogue, category: category,sub_category: subcategory,mini_category: minicategory, micro_category: microcategory, brand: brand, status: true, seller: account) 
  product_content = FactoryBot.create(:product_content, catalogue: catalogue, feature_bullets_attributes: [{value: "feature 1"}], image_urls_attributes: [{url: "www.img1.com"}])
  low_stock_prod = FactoryBot.create(:catalogue, category: category,sub_category: subcategory,mini_category: minicategory, micro_category: microcategory, brand: brand, status: true, seller: account, stocks: 0)
  lsp_product_content = FactoryBot.create(:product_content, catalogue: low_stock_prod, feature_bullets_attributes: [{value: "feature 2"}], image_urls_attributes: [{url: "www.img2.com"}])
  favourite = FactoryBot.create(:favourite, user_id: buyer.id, favouriteable_id: catalogue.id)
  review_seller = FactoryBot.create(:review, reviewer_id: buyer.id, catalogue: catalogue, account_id: account.id,review_type: 'seller', is_approved: true )
  review_catalogue = FactoryBot.create(:review, rating: 4, reviewer_id: buyer.id, catalogue: catalogue, account_id: account.id,review_type: 'product', is_approved: true )
  deal = FactoryBot.create(:deal)
  deal_catalogue = FactoryBot.create(:deal_catalogue, deal: deal, catalogue: catalogue, seller: seller2, status: 'approved' )
  rating = 4
  reviews = FactoryBot.create_list(:review, 3, reviewer_id: buyer.id, catalogue: catalogue, account_id: account.id, rating: rating, review_type: 'product', is_approved: true)
  search_catalogue_error = "Seller SKU not found"
  catalogue_params = {
    parent_catalogue_id: parent_catalogue.id,
    category_id: category.id,
    sub_category_id: subcategory.id,
    mini_category_id: minicategory.id,
    micro_category_id: microcategory.id,
    brand_id: brand.id,
    sku: Faker::Alphanumeric.alphanumeric(number: 14, min_numeric: 5),
    besku: parent_catalogue.besku,
    product_image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'Sample.jpg')),
    status: 'active'
  }

  file_type = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  ship_unit = ['Centimeter','Meter','Inch','Feet']
  columns_and_values = {
        'Category': category&.name,
        'SubCategory': subcategory&.name,
        'MiniCategory': minicategory&.name,
        'Micro Category': microcategory&.name,
        'Brand Name': brand&.brand_name,
        'Seller SKU': nil,
        'Product Title': nil,
        'Product Image': nil,
        'GTIN': nil,
        'MRP': nil,
        'Retail Price': nil,
        'Long Description': nil,
        'Whats in the Package': nil,
        'Country of Origin': CS.countries.map { |c| c[1] },
        'Product Color': ["Purple", "Light Coral","Lime Green", "Yellow", "Grey", "Ocean Green", "Pink", "Sky blue"],
        'Warranty Days': nil,
        'Warranty Months': nil,
        'Feature Bullet 1': nil,
        'Feature Bullet 2': nil,
        'Feature Bullet 3': nil,
        'Feature Bullet 4': nil,
        'Size': nil,
        'Size Unit': ['Grams','KiloGrams','Centimeter','Millimeter'],
        'Capacity': nil,
        'Capacity Unit': ['Litre','Millilitre'],
        'HS Code': nil,
        'Prod Model Name': nil,
        'Prod Model Number': nil,
        'Number of Pieces': nil,
        'Shipping Length': nil,
        'Shipping Length Unit': ship_unit,
        'Shipping Height': nil,
        'Shipping Height Unit': ship_unit,
        'Shipping Width': nil,
        'Shipping Width Unit': ship_unit,
        'Shipping Weight': nil,
        'Shipping Weight Unit': ['Kilogram','Gram','Ounce (OZ)','pound (lb)'],
        'Image URL 1': nil,
        'Image URL 2': nil,
        'Image URL 3': nil,
        'Image URL 4': nil,
        'Image URL 5': nil,
        'Image URL 6': nil,
        "#{custom_field.field_name}": custom_field.custom_fields_options.map(&:option_name)
      }
  csv_header = columns_and_values.keys.map(&:to_s)
  prod_image = "https://fastly.picsum.photos/id/20/3670/2462.jpg?hmac=CmQ0ln-k5ZqkdtLvVO23LjVAEabZQx2wOaT4pyeG10I"
  csv_file_path = Rails.root.join('spec', 'fixtures', 'files/product_upload_template_valid.xlsx')
  invalid_csv_file_path = Rails.root.join('spec', 'fixtures', 'files/product_upload_template_invalid.xlsx')

  def generate_csv_file(data, file_path)
    workbook = WriteXLSX.new(file_path)
    worksheet = workbook.add_worksheet

    data.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        worksheet.write(row_index, col_index, cell)
      end
    end
    workbook.close
  end


  describe 'POST create' do
    it 'creates a new catalogue and returns status :created' do
      post :create, params: catalogue_params.merge({token: token})

      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['category_id']).to eq(category.id)
      expect(json_response['data']['attributes']['sub_category']['name']).to eq(subcategory.name)
      expect(json_response['data']['attributes']['mini_category']['name']).to eq(minicategory.name)
      expect(json_response['data']['attributes']['micro_category']['name']).to eq(microcategory.name)
      expect(json_response['data']['attributes']['besku']).to eq(parent_catalogue.besku)
      expect(json_response['data']['attributes']['final_price']).to eq("0.0")
      expect(BxBlockActivitylog::ActivityLog.find_by(user_id: account.id).action).to eq("Product Created!")
    end

    it 'returns status :unprocessable_entity if the catalogue creation fails' do
      post :create, params: catalogue_params.merge({token: token}).except(:category_id)
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to eq(["Category must exist"])
    end
  end

  describe 'GET show' do
    before do
      request.headers['Authorization'] = token
    end
  
    context 'when the catalogue exists with an active offer' do
      let(:catalogue) { FactoryBot.create(:catalogue, parent_catalogue: parent_catalogue, category: category, sub_category: subcategory, mini_category: minicategory, micro_category: microcategory, brand: brand, status: true, seller: account) }
      let!(:catalogue_offer) { FactoryBot.create(:catalogue_offer, catalogue: catalogue, sale_schedule_from: Date.today, sale_schedule_to: Date.today) }
  
      it 'updates the catalogue price details and returns status :ok' do
        get :show, params: { id: catalogue.id }
  
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
  
        expect(json_response['data']['attributes']['final_price']).to eq(catalogue.calculate_effective_price.to_s)
        expect(json_response['data']['attributes']['offer_percentage']).to eq(catalogue.calculate_offer_percentage)
        expect(json_response['data']['attributes']['stroked_price']).to eq(catalogue.calculate_stroked_price)
      end
    end
  
    context 'when the catalogue exists without an active offer' do
      let(:catalogue) { FactoryBot.create(:catalogue, parent_catalogue: parent_catalogue, category: category, sub_category: subcategory, mini_category: minicategory, micro_category: microcategory, brand: brand, status: true, seller: account) }
      let!(:catalogue_offer) { FactoryBot.create(:catalogue_offer, catalogue: catalogue, sale_schedule_from: Date.today + 1, sale_schedule_to: Date.today + 2) }
  
      it 'sets offer_percentage to 0.0 and returns status :ok' do
        get :show, params: { id: catalogue.id }
  
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
  
        expect(json_response['data']['attributes']['offer_percentage']).to eq(0.0)
      end
    end
  
    context 'when the catalogue does not exist' do
      it 'returns status :not_found' do
        get :show, params: { id: 99999 } # Assuming ID does not exist
  
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET Sku validate' do
    it 'returns the sku params missing' do

      get :sku_validate, params: { token: token }

      expect(response).to have_http_status(:bad_request)
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('SKU parameter is missing')
    end

    it 'returns status :conflict if the catalogue is exist' do
      get :sku_validate, params: { token: token,sku: catalogue.sku }

      expect(response).to have_http_status(:conflict)
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Already exist in database')
    end

    it 'returns status :ok if the catalogue is not exist' do
      get :sku_validate, params: { token: token,sku: "a1#{Faker::Alphanumeric.alphanumeric(number: 14, min_numeric: 5)}b1" }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('SKU is valid')
    end
  end

  describe 'GET index' do
    catalogue_list = FactoryBot.create_list(:catalogue,2, parent_catalogue: parent_catalogue, category: category, brand: brand, seller: account) 
    it 'returns all catalogues' do

      get :index, params: {token: token}

      expect(response).to have_http_status(:ok)
      # expect(JSON.parse(response.body)['data'].map(&:id)).to include(catalogue_list.last.id.to_s)
    end

    it 'returns all catalogues sort by whats_new' do

      get :index, params: {token: token, sort_by: 'whats_new'}

      expect(response).to have_http_status(:ok)
    end

    it 'returns all catalogues search by fulfillment content_status and live_status' do
      get :index, params: {
        token: token,
        fulfillment: ["byezzy"],
        content_status: ["accepted"],
        live_status: [true]
      }
      expect(response).to have_http_status(:ok)
    end

    it 'returns all catalogues sort by popularity' do

      get :index, params: {token: token, sort_by: 'popularity'}

      expect(response).to have_http_status(:ok)
    end

    it 'returns all searched catalogues' do

      get :index, params: {token: token, search: brand.brand_name}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include('data') 
      expect(JSON.parse(response.body)['data'][0]['attributes']['final_price']).to be_an_instance_of(String)
      expect(JSON.parse(response.body)['data'][0]['attributes']['brand_id']).to eq(brand.id)
    end
  end

  describe 'GET search_catalogues_by_brand' do
    brand_catalogue_list = FactoryBot.create_list(:catalogue,2, category: category, micro_category: microcategory, brand: brand, seller: account) 
    catalogue_prod_content = FactoryBot.create(:product_content, catalogue: brand_catalogue_list.last, feature_bullets_attributes: [{value: "feature 3"}], image_urls_attributes: [{url: "www.img3.com"}]) 
    it 'returns all catalogues by brands' do

      get :search_catalogues_by_brand, params: {token: token, brand_id: brand.id, micro_category_id: microcategory.id}

      expect(response).to have_http_status(:ok)
    end

    it 'returns all searched catalogues by title&brand' do

      get :search_catalogues_by_brand, params: {token: token, micro_category_id: microcategory.id, brand_id: brand.id, product_keyword: catalogue_prod_content.product_title}

      expect(JSON.parse(response.body)['data'][0]['attributes']['product_content']['product_attributes']['product_title']).to eq(catalogue_prod_content.product_title)
    end
    
  end

  describe 'PATCH update' do
    it 'updates the specified catalogue and returns status :ok' do

      patch :update, params: { token: token,
        id: catalogue.id,
        status: 'inactive'
      }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['status']).to eq(true)
      expect(json_response['data']['attributes']['product_content']['custom_fields_contents'].last['custom_field_name']).to include(custom_field.field_name)
    end

    it 'returns status :not_found if the catalogue is not found' do
      patch :update, params: { token: token, id: 0, status: 'inactive' }

      expect(response).to have_http_status(:not_found)
    end

    it 'returns status :unprocessable_entity if the catalogue update fails' do
      patch :update, params: { token: token,
        id: catalogue.id,
        brand_id: nil
      }
      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to eq(["Brand must exist"])
    end
  end

  describe "GET #search_catalogue" do
    it "returns matching catalogue based on the keyword" do
      variant_product = FactoryBot.create(:catalogue, sku: catalogue.sku, parent_product: catalogue, is_variant: true,seller: account)
      product_variant_group = FactoryBot.create(:product_variant_group, catalogue: catalogue, variant_product: variant_product)

      get :search_catalogues, params: {token: token, keyword: variant_product.product_variant_group.product_sku}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"].size).to eq(2)
      expect(JSON.parse(response.body)["data"][0]["attributes"]["sku"]).to eq(catalogue.sku)
      expect(JSON.parse(response.body)["data"][1]["attributes"]["sku"]).to eq(variant_product.sku)
      expect(JSON.parse(response.body)["data"][1]["attributes"]["variant_product_group"]['product_bibc']).to eq(variant_product.product_variant_group.product_bibc)
    end

    it "returns an empty list if no matching catalogue found" do
      keyword = "non_matching_keyword"

      get :search_catalogues, params: {token: token, keyword: "some_keyword" }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["message"]).to eq(search_catalogue_error)
    end

    it "returns an catalogue which doesnt have offer" do
      off_product = FactoryBot.create(:catalogue, seller: account)
      offerp = FactoryBot.create(:catalogue_offer, catalogue: off_product, status: true)

      get :search_catalogues, params: {token: token, keyword: off_product.sku }

      expect(JSON.parse(response.body)["message"]).to eq(search_catalogue_error)
    end
  end

  describe 'GET template_download' do
    it 'returns a JSON file with the correct headers and values' do
      get :template_download, params: {
        category_id: category.id,
        subcategory_id: subcategory.id,
        minicategory_id: minicategory.id,
        microcategory_id: microcategory.id,
        brand_id: brand.id,
        token: token
      }

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)

      expect(json_response['headers']).to eq(csv_header)

      values = json_response['values'].transform_keys(&:to_sym)

      expect(values).to eq(columns_and_values)
    end
  end

  describe 'POST bulk_upload' do

    before(:all) do
      FileUtils.mkdir_p(File.dirname(csv_file_path))
      sku_1 = Faker::Alphanumeric.alphanumeric(number: 14, min_numeric: 5)
      sku_2 = Faker::Alphanumeric.alphanumeric(number: 14, min_numeric: 5)
      custom_option = "My Option"

      csv_data = [
        csv_header,
        [category.name, subcategory.name, minicategory.name, microcategory.name, brand.brand_name,sku_1,"Product Title10",prod_image,Faker::Number.number(digits: 9),100,234,"lonnnnnnnnnnnnnnnnnng descrippppppppppppion","wts","India","grey","","","ahjd","def","FB1","","","","","","","","","","","","","","","","","","","","https://www.sjd.com","","","",custom_option],
        [category.name, subcategory.name, minicategory.name, microcategory.name, brand.brand_name,sku_2,"Product Title20","",Faker::Number.number(digits: 9),100,234,"lonnnnnnnnnnnnnnnnng descripppppppppppion","wts","India","grey","","","shdj","djf","FB1","","","","","","","","","","","","","","","","","","","","https://www.sjd2.com","","","",custom_option],
      ]

      csv_invalid_data = [
        csv_header,
        ['unknown12cat', subcategory.name, minicategory.name, microcategory.name, brand.brand_name,Faker::Alphanumeric.alpha(number: 5),"Product Title11",prod_image,parent_catalogue.besku],
        [category.name, subcategory.name, 'unknownminicat', microcategory.name, brand.brand_name,Faker::Alphanumeric.alpha(number: 5),"Product Title12",prod_image,parent_catalogue.besku],
        [category.name, 'unknownsubcat', minicategory.name, microcategory.name, brand.brand_name,Faker::Alphanumeric.alpha(number: 5),"Product Title13",prod_image,parent_catalogue.besku],
        [category.name,  subcategory.name, minicategory.name, 'unknownmicrocat', brand.brand_name,Faker::Alphanumeric.alpha(number: 5),"Product Title14",prod_image,""],
        [category.name, subcategory.name, minicategory.name, microcategory.name, brand.brand_name,catalogue.sku,"Product Title15",prod_image,nil,"",100,234,"lonnnnnnnnnnnnnnnnng descrippp2pppppppion","","India","grey","","","FB1","","","","","","","","","","","","","","","","","","","httpp//","www."],
        [category.name, subcategory.name, minicategory.name, microcategory.name, restricted_brand.brand_name,"asdfdf","Product Title16"],
        [category.name, subcategory.name, minicategory.name, microcategory.name, brand.brand_name,"valid123valid","tile 1",prod_image,Faker::Number.number(digits: 9),100,234,"lonnnnnnnnnn2nnnng descripppppppppppion","Product Titl20","India","grey","","","FB1","","","","","","","","","prod 6","","",4,"mc",7,"cm","","","","","","","","",custom_option],
        [category.name, subcategory.name, minicategory.name, microcategory.name, brand.brand_name,"valid123valid","title 8",prod_image,Faker::Number.number(digits: 9),100,234,"lonnnnnnnnnnnnnnnnng descripppppppppppion","wts","India","grey","","","","","","","","","","","","","","","","","","","","","","","","","https://www.sjd3.com","","","",custom_option],
        [category.name, subcategory.name, minicategory.name, microcategory.name, brand.brand_name,"valid13valid","title 9",prod_image,Faker::Number.number(digits: 9),100,234,"lonnnnnnnnnnnnnnnnng descrippppppppqpppion","wts1","India","grey","1234","","FB11","","","",2,"","","litre","","","","","3","","","meter","2","","","meter","","","https://www.sjd4.com","","","",custom_option],
        csv_data[2]
      ]

      generate_csv_file(csv_data, csv_file_path)
      generate_csv_file(csv_invalid_data, invalid_csv_file_path)
    end

    let(:csv_file) { fixture_file_upload('files/product_upload_template_valid.xlsx', file_type) }

    it 'creates catalogues from a valid CSV file' do
      post :bulk_upload, params: { file: csv_file, token: token }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Bulk upload completed successfully')
      expect(json_response['successful_rows']).not_to be_empty 
    end

    it 'handles validation errors in the CSV file' do
      invalid_csv_file = fixture_file_upload('files/product_upload_template_invalid.xlsx', file_type)

      post :bulk_upload, params: { file: invalid_csv_file, token: token }

      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Bulk upload completed with errors')
      expect(json_response['skipped_rows']).not_to be_empty
      expect(json_response['skipped_rows']).to include("Row 4: Microcategory not found or created.")
      expect(json_response['validation_errors']).to include("Row 6: The brand '#{restricted_brand.brand_name}' you have selected has some restrictions for sellers or distributors,if you have products of the brand, please submit a permit to sell under this brand, and submit a request for approval.")
      expect(json_response['validation_errors']).to include("Row 5: Validation error(s): SKU / Product is already added, Image urls url should start with 'https://' or 'www.', Country of origin can't be blank, Warranty days must be integer and no more than 3 digits, Product color is not a valid product color")
      expect(json_response['validation_errors']).to include("Row 7: Validation error(s): Image urls url should start with 'https://' or 'www.', Shipping detail shipping length unit is not valid. It must be one of: Kilogram, Gram, Ounce (OZ), pound (lb), Centimeter, Meter, Inch, Feet, Shipping detail shipping height unit is not valid. It must be one of: Kilogram, Gram, Ounce (OZ), pound (lb), Centimeter, Meter, Inch, Feet")
      expect(json_response['validation_errors']).to include("Row 8: Validation error(s): Feature bullets At least one feature bullet must be present")
      expect(json_response['validation_errors']).not_to include("Row 8: Validation error(s): Unique psku can't be blank")
      expect(json_response['validation_errors']).to include("Row 9: Validation error(s): Shipping detail shipping length unit must be present if shipping_length is provided, Shipping detail shipping height must be present if shipping_height_unit is provided, Shipping detail shipping width unit must be present if shipping_width is provided, Shipping detail shipping weight must be present if shipping_weight_unit is provided, Size and capacity size unit must be present if size is provided, Size and capacity capacity must be present if capacity_unit is provided, Warranty days must be integer and no more than 3 digits")
      expect(json_response['successful_rows']).to include("Row 10: Uploaded successfully")
      expect(json_response['validation_errors']).not_to be_empty
    end

    it 'handles an invalid file format' do
      invalid_file = fixture_file_upload('files/document.doc')

      post :bulk_upload, params: { file: invalid_file, token: token }

      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Invalid file format')
    end

    # it 'handles empty file csv' do
    #   empty_csv_file_path = Rails.root.join('spec', 'fixtures', 'files', 'empty_file.csv')
    #   FileUtils.touch(empty_csv_file_path)

    #   empty_csv_file = fixture_file_upload('files/empty_file.csv', file_type)
    #   post :bulk_upload, params: { file: empty_csv_file, token: token }

    #   expect(response).to have_http_status(:unprocessable_entity)
    #   json_response = JSON.parse(response.body)
    #   expect(json_response['error']).to eq("The uploaded file contains an invalid format. Error: Invalid byte sequence in UTF-8 in line 1. Please check the file and try again.")
    # end

    it 'handles empty file xlsx' do
      empty_csv_file_path = Rails.root.join('spec', 'fixtures', 'files', 'empty_file.xlsx')
      FileUtils.touch(empty_csv_file_path)

      empty_csv_file = fixture_file_upload('files/empty_file.xlsx', file_type)
      post :bulk_upload, params: { file: empty_csv_file, token: token }

      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('The uploaded file does not contain any data.')
    end

    it 'handles missing mandatory custom fields' do
      sku_3 = Faker::Alphanumeric.alphanumeric(number: 14, min_numeric: 5)
      missing_custom_fields_csv_file_path = Rails.root.join('spec', 'fixtures', 'files', 'missing_custom_fields_file.xlsx')
      generate_csv_file([csv_header, [category.name, subcategory.name, minicategory.name, microcategory_2.name, brand.brand_name,sku_3,"invaid test prod",prod_image,Faker::Number.number(digits: 9),310,284,"lonnnnnnnnnnng descppppppppppion","invaid test prod","India","grey","","","uyeiu","FB1","","","","","","","","","","","","","","","","","","","https://www.djhd.com"]], missing_custom_fields_csv_file_path)
      missing_custom_fields_csv_file = fixture_file_upload('files/missing_custom_fields_file.xlsx', file_type)

      post :bulk_upload, params: { file: missing_custom_fields_csv_file, token: token }

      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response['skipped_rows']).not_to be_empty
      expect(json_response['validation_errors']).to include("Row 1: Mandatory field '#{custom_field_2.field_name}' is missing")
    end

  end

  describe 'GET list_catalogue_by_category' do

    it 'returns products associated with the provided micro category' do

      post :list_catalogue_by_category, params: { category_id: category.id, sub_category_id: subcategory.id, mini_category_id: minicategory.id, micro_category_id: microcategory.id, out_of_stocks: false, token: token }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].first['attributes']['category']['name']).to include(category.name)
      expect(JSON.parse(response.body)['data'].first['attributes']['sub_category']['name']).to include(subcategory.name)
      expect(JSON.parse(response.body)['data'].first['attributes']['mini_category']['name']).to include(minicategory.name)
      expect(JSON.parse(response.body)['data'].first['attributes']['micro_category']['name']).to include(microcategory.name)
      expect(JSON.parse(response.body)['data'].map {|i| i['attributes']['stocks']}[0]).to be > 0
    end

    it 'returns products associated with the provided micro category' do

      post :list_catalogue_by_category, params: { category_id: category.id, sub_category_id: subcategory.id, mini_category_id: minicategory.id, micro_category_id: microcategory.id, out_of_stocks: true, token: token }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].last['attributes']['category']['name']).to include(low_stock_prod.category.name)
      expect(JSON.parse(response.body)['total_count']).to eq(1)
    end

    it 'returns products associated with the provided brand' do

      post :list_catalogue_by_category, params: { brand_id: brand.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].last['attributes']['brand_id']).to eq(brand.id)
    end

    it 'returns products associated with the provided deal' do

      post :list_catalogue_by_category, params: { deal_id: deal.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].first['id']).to include(catalogue.id.to_s)
      expect(JSON.parse(response.body)['data'].first['attributes']['deals'][0]['deal_name']).to include(deal.deal_name)
    end

    it 'returns no products if no category_id, sub_category_id, mini_category_id, or micro_category_id provided' do
      post :list_catalogue_by_category, params: { category_id: 0  }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['message']).to eq('No products found')
      expect(JSON.parse(response.body)['total_count']).to eq(0)
    end

    it 'filters products by custom field values' do
      custom_field_values = ['value1', 'value2']
      catalogue_content1 = FactoryBot.create(:catalogue_content, catalogue: catalogue, custom_field: custom_field, value: custom_field_values.first)
      catalogue_content2 = FactoryBot.create(:catalogue_content, catalogue: catalogue, custom_field: custom_field, value: custom_field_values.second)

      post :list_catalogue_by_category, params: { category_id: category.id, sub_category_id: subcategory.id, mini_category_id: minicategory.id, micro_category_id: microcategory.id, custom_field_values: custom_field_values, token: token }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].map { |item| item['id'] }).to include(catalogue.id.to_s)
    end

    it 'filters products by rating' do
      
      post :list_catalogue_by_category, params: { category_id: category.id, sub_category_id: subcategory.id, mini_category_id: minicategory.id, micro_category_id: microcategory.id, filter_by_rating: [rating], token: token }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].map { |item| item['id'] }).to include(catalogue.id.to_s)
    end

    it 'filters products by rating with precise number' do
      reviews.last.rating = 3.5
      reviews.last.save

      post :list_catalogue_by_category, params: { category_id: category.id, sub_category_id: subcategory.id, mini_category_id: minicategory.id, micro_category_id: microcategory.id, filter_by_rating: [reviews.last.rating], token: token }

      expect(JSON.parse(response.body)['data'].map { |item| item['id'] }).to include(catalogue.id.to_s)
    end

    it 'sort products by rating' do
      post :list_catalogue_by_category, params: { category_id: category.id, sub_category_id: subcategory.id, mini_category_id: minicategory.id, micro_category_id: microcategory.id, sort_by: "customer_rating", token: token }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].first['id']).to include(catalogue.id.to_s)
    end

    it 'sort products by recommended' do
      catalogue2 = FactoryBot.create(:catalogue, category: category,sub_category: subcategory,mini_category: minicategory, micro_category: microcategory, brand: brand, status: true, seller: account, recommended_priority: 9) 
      product_content2 = FactoryBot.create(:product_content, catalogue: catalogue2, feature_bullets_attributes: [{value: "feature 4"}], image_urls_attributes: [{url: "www.img4.com"}])
      post :list_catalogue_by_category, params: { category_id: category.id, sub_category_id: subcategory.id, mini_category_id: minicategory.id, micro_category_id: microcategory.id, sort_by: "recommended", token: token }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].first['id']).to include(catalogue2.id.to_s)
    end

    it 'filter by product color' do
      catalogue3 = FactoryBot.create(:catalogue, category: category,sub_category: subcategory,mini_category: minicategory, micro_category: microcategory, brand: brand, status: true, seller: account) 
      product_content3 = FactoryBot.create(:product_content, catalogue: catalogue3, product_color: "grey", feature_bullets_attributes: [{value: "feature 5"}], image_urls_attributes: [{url: "www.img5.com"}])
      post :list_catalogue_by_category, params: { category_id: category.id, color_filter: ["grey"] }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].first['id']).to include(catalogue3.id.to_s)
    end

    it 'filters products by price range' do
      post :list_catalogue_by_category, params: { category_id: category.id, min_price: 10, max_price: 100, token: token }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("data", "total_count", "message")
    end

    it 'returns no produncts when filtering by an out-of-range price' do
      post :list_catalogue_by_category, params: { category_id: category.id, min_price: 1000, max_price: 2000, token: token }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']).to be_empty
    end

    it 'handles invalid sorting parameter gracefully' do
      post :list_catalogue_by_category, params: { category_id: category.id, sort_by: "invalid", token: token }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include('data', 'total_count', 'message')
      expect(JSON.parse(response.body)['data']).to be_an(Array)
      expect(JSON.parse(response.body)['message']).to eq("Successfully Loaded")
    end
  end

  describe 'get search_catalogues_by_title_or_brand_name' do

    context 'when product and brand are provided' do
      it 'returns matching catalogues for product and brand' do
        get :search_catalogues_by_title_or_brand_name, params: { product_keyword: catalogue.product_title, brand_keyword: brand.brand_name, token: token }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data'].map { |item| item['id'] }).to include(catalogue.id.to_s)
      end

      it 'returns matching catalogues for product and brand' do
        get :search_catalogues_by_title_or_brand_name, params: {token: token , product_keyword: catalogue.sku }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data'][0]['attributes']['sku']).to eq(catalogue.sku)
      end

      it 'returns products which doesnt have warehouse' do
        warehouse_c1 = FactoryBot.create(:warehouse, account: account)
        c1 = FactoryBot.create(:catalogue, seller: account)
        prod_c1 = FactoryBot.create(:product_content, catalogue: c1)
        warehouse_catalogue_c1 = FactoryBot.create(:warehouse_catalogue, warehouse: warehouse_c1, catalogue: c1, stocks: 8)

        warehouse_c2 = FactoryBot.create(:warehouse, account: account)
        c2 = FactoryBot.create(:catalogue, seller: account)
        prod_c2 = FactoryBot.create(:product_content, catalogue: c2)
        warehouse_catalogue_c1 = FactoryBot.create(:warehouse_catalogue, warehouse: warehouse_c2, catalogue: c2, stocks: 6)

        get :search_catalogues_by_title_or_brand_name, params: {token: token, warehouse_id: warehouse_c2.id }
        expect(JSON.parse(response.body)['data'][0]['attributes']['sku']).not_to eq(c1.sku)
      end

      it 'returns matching catalogues for products by brand' do
        get :search_catalogues_by_title_or_brand_name, params: {token: token , product_keyword: catalogue.sku, brand_id: brand.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data'][0]['attributes']['sku']).to eq(catalogue.sku)
        expect(JSON.parse(response.body)['data'][0]['attributes']['brand_id']).to eq(brand.id)
      end

      it 'returns matching catalogues for products by brand' do
        variant_product = FactoryBot.create(:catalogue, sku: catalogue.sku, parent_product: catalogue, is_variant: true, seller: account, brand: brand)
        product_variant_group = FactoryBot.create(:product_variant_group, catalogue: catalogue, variant_product: variant_product)
        get :search_catalogues_by_title_or_brand_name, params: {token: token , product_keyword: variant_product.product_variant_group.product_sku, brand_id: brand.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data'][0]['attributes']['sku']).to eq(variant_product.sku)
        expect(JSON.parse(response.body)['data'][0]['attributes']['brand_id']).to eq(brand.id)
      end
    end

    context 'when only product keyword is provided' do
      it 'returns matching catalogues based on the product' do
        get :search_catalogues_by_title_or_brand_name, params: {token: token , brand_keyword: brand.brand_name }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data'][0]['attributes']['brand']['brand_name']).to include(brand.brand_name)
      end
    end

    context 'when no matching products or brands are found' do
      it 'returns a not found message' do
        post :search_catalogues_by_title_or_brand_name, params: {token: token , product_keyword: 'Product3' }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('No products found')
      end
    end
  end

  describe 'get list_store_menu_products' do
    context 'when store menu provided' do
      store = FactoryBot.create(:store)
      catalogues = FactoryBot.create_list(:catalogue, 2)
      menu = FactoryBot.create(:store_menu, store: store, catalogues: catalogues)
      it 'returns matching catalogues for menu id' do
        get :list_store_menu_products, params: { menu_id: menu.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data'][0]['id']).to eq(catalogues.first.id.to_s)
      end

      context 'when no matching or menu are found' do
        it 'returns a not found message for menu' do
          post :list_store_menu_products, params: {menu_id: 0 }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['error']).to eq("Menu not found")
        end
      end
    end
  end

end
