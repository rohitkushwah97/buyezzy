module BxBlockCatalogue
  class CataloguesController < ApplicationController
    include BxBlockCatalogue::CatalogueSearch
    before_action :load_catalogue, only: %i[show update]
    before_action :validate_json_web_token, only: [:create, :update, :template_download, :bulk_upload, :index, :search_catalogues, :search_catalogues_by_title_or_brand_name, :search_catalogues_by_brand]
    before_action :find_seller, only: [:create, :update, :bulk_upload, :index, :search_catalogues, :search_catalogues_by_title_or_brand_name, :search_catalogues_by_brand]

    #Declared Because Of CODE SMELL issue
    MICRO_CATEGORY_COLUMN = 'Micro Category'.freeze
    BRAND_NAME_COLUMN = 'Brand Name'.freeze

    def create
      catalogue = Catalogue.new(catalogue_params.merge(seller: @seller))

      if catalogue.save
        product_activity_log(@seller, "Product Created!", "Product #{catalogue.sku} was created by #{@seller&.full_name}")
        render json: CatalogueSerializer.new(catalogue)
        .serializable_hash,
        status: :created
      else
        render json: { errors: format_activerecord_errors(catalogue.errors) },
        status: :unprocessable_entity
      end
    end

    def show
      return if @catalogue.nil?
      if @catalogue.catalogue_offer && @catalogue.catalogue_offer.sale_schedule_from.present? && @catalogue.catalogue_offer.sale_schedule_to.present? && @catalogue.catalogue_offer.sale_schedule_from <= Date.today && @catalogue.catalogue_offer.sale_schedule_to >= Date.today
        @catalogue.update_columns(
          final_price: @catalogue.calculate_effective_price,
          offer_percentage: @catalogue.calculate_offer_percentage,
          stroked_price: @catalogue.calculate_stroked_price
        )
      else
        @catalogue.update!(offer_percentage: 0.0)
      end
    
      render json: CatalogueSerializer.new(@catalogue)
        .serializable_hash.merge(favourite: check_favourite_for_buyer(@catalogue, params)),
        status: :ok
    end

# // for seller product list
    def index
      per_page = params[:per_page].presence&.to_i || 10
      page_number = params[:page].presence&.to_i || 1
      total_count = 0

      catalogues = Catalogue.includes(:brand).includes(:product_content, :catalogue_offer).includes(:product_variant_groups).where(seller: @seller, is_variant: false)

      if params[:search].present?
        search_query = params[:search].strip.downcase

        catalogues = catalogues.where("LOWER(product_contents.product_title) LIKE :query OR LOWER(sku) LIKE :query OR LOWER(besku) LIKE :query OR LOWER(brands.brand_name) LIKE :query OR LOWER(product_variant_groups.product_sku) LIKE :query",
         query: "%#{search_query}%").references(:brand)
      end

      catalogues = filter_catalogues(catalogues,params)

      if params[:sort_by].present?
        catalogues = sort_catalogues(catalogues, params[:sort_by])
      else
        catalogues = catalogues.order(created_at: :desc)
      end
      
      if catalogues.present?
        total_count = catalogues.count
        paginated_catalogues = paginate_catalogues(catalogues, page_number, per_page)
      end

      render json: CatalogueSerializer.new(paginated_catalogues || []).serializable_hash.merge(total_count: total_count), status: :ok
    end

# // for deals catalogue list
    def search_catalogues
      if params[:keyword].present?
        keyword = params[:keyword].to_s.strip.downcase
        excluded_catalogue_ids = DealCatalogue
                           .where(seller_id: @seller.id)
                           .where(status: ['review', 'approved'])
                           .pluck(:catalogue_id)

        excluded_catalogue_ids << CatalogueOffer.where('sale_schedule_to >= ? AND status = ?', Date.today, true).pluck(:catalogue_id)

        excluded_catalogue_ids.flatten!

        parent_catalogues = Catalogue
                             .includes(:product_variant_groups)
                             .references(:product_variant_groups)
                             .where("LOWER(catalogues.sku) LIKE :query OR LOWER(product_variant_groups.product_sku) LIKE :query", query: "%#{keyword}%")
                             .where(seller: @seller)
                             .where.not(id: excluded_catalogue_ids)

        variant_catalogues = Catalogue
                               .includes(:variant_products, :product_variant_group)
                               .references(:variant_products, :product_variant_group)
                               .where("LOWER(product_variant_groups.product_sku) LIKE :query OR LOWER(variant_products_catalogues.sku) LIKE :query", query: "%#{keyword}%")
                               .where(seller: @seller)
                               .where.not(id: excluded_catalogue_ids)

        @catalogues = (parent_catalogues + variant_catalogues).uniq

        if @catalogues.any?
          render json: CatalogueSerializer.new(@catalogues).serializable_hash, status: :ok
        else
          render json: {
            message: "Seller SKU not found"
          }, status: :not_found
        end
      end
    end

# // for store products list
    def search_catalogues_by_title_or_brand_name
      per_page = params[:per_page].presence&.to_i || 10
      page_number = params[:page].presence&.to_i || 1
      product_keyword = params[:product_keyword].to_s.strip
      brand_keywords = params[:brand_keyword]&.split(',')&.map(&:strip)
      brand_id = params[:brand_id]
      warehouse_id = params[:warehouse_id]
      catalogues_scope = Catalogue.left_joins(:product_content).left_joins(:product_variant_groups).where(seller: @seller).where.not(product_contents: { id: nil })

      variant_product_ids = []
      warehouse_catalogue_ids = []

      if product_keyword.present?
        catalogues_scope = product_search_by_title(product_keyword, catalogues_scope, 'include_sku')
        variant_product_ids = variant_product_search(product_keyword, @seller, brand_id).pluck(:id)
      end

      if brand_keywords.present?
        brand_ids = brand_ids_by_brand_name_keyword(brand_keywords)
        catalogues_scope = catalogues_scope.where(brand_id: brand_ids)
      end

      if brand_id.present?
        catalogues_scope = catalogues_scope.where(brand_id: brand_id)
      end

      if warehouse_id.present?
        warehouse_catalogue_ids = WarehouseCatalogue.where.not(warehouse_id: warehouse_id).pluck(:catalogue_id)
      end

      catalogue_ids = (catalogues_scope.pluck(:id) + variant_product_ids) - warehouse_catalogue_ids
      unique_catalogue_ids = catalogue_ids.uniq

      @catalogues = Catalogue.where(id: unique_catalogue_ids)
      total_count = unique_catalogue_ids.size

      if total_count > 0
        @catalogues = paginate_catalogues(@catalogues, page_number, per_page)
        render json: CatalogueSerializer.new(@catalogues).serializable_hash.merge(total_count: total_count), status: :ok
      else
        render_no_product_found
      end
    end

 # // for seller existing products list in product create flow
    def search_catalogues_by_brand
      per_page = params[:per_page].presence&.to_i || 10
      page_no = params[:page].presence&.to_i || 1
      brand_id = params[:brand_id]
      micro_category_id = params[:micro_category_id]
      total_count = 0

      catalogues = Catalogue.includes(:product_content).where(brand_id: brand_id, micro_category_id: micro_category_id).order(created_at: :desc)

      if params[:product_keyword].present?
        product_keyword = params[:product_keyword].strip.downcase

        catalogues = catalogues.where("LOWER(product_contents.product_title) LIKE :query",query: "%#{product_keyword}%").references(:product_contents)
      end

      if catalogues.present?
        total_count = catalogues.count
        catalogues = paginate_catalogues(catalogues, page_no, per_page)
      end

      render json: CatalogueSerializer.new(catalogues).serializable_hash.merge(total_count: total_count), status: :ok
    end

# // catalogues by category or deal
    def list_catalogue_by_category
      category = BxBlockCategories::Category.find_by(id: params[:category_id])
      deal = Deal.active_deals.find_by(id: params[:deal_id])
      brand = Brand.find_by(id: params[:brand_id], approve: true)

      return render_no_product_found unless category.present? || deal.present? || brand.present?

      if deal.present?
        catalogues_ids = catalogues_by_active_deals(params[:deal_id])
        catalogues = Catalogue.joins(:product_content).where(id: catalogues_ids, status: true)
      elsif brand.present?
        catalogues = Catalogue.joins(:product_content).where(brand_id: params[:brand_id], status: true)
      else
        catalogues = Catalogue.joins(:product_content).where(category_id: params[:category_id], status: true)
      end

      if params[:out_of_stocks]&.to_s == 'true'
        catalogues = catalogues.where('COALESCE(stocks, 0) <= ?', 0)
      elsif params[:out_of_stocks]&.to_s == 'false'
        catalogues = catalogues.where('COALESCE(stocks, 0) > ?', 0)
      end

      min_range, max_range = get_min_max_value(catalogues)

      apply_category_filters(catalogues)

      if params[:custom_field_values].present?
        catalogues = filter_by_custom_field_values(catalogues, params[:custom_field_values])
      end

      if params[:filter_by_rating].present?
        catalogues = filter_by_ratings(catalogues,params[:filter_by_rating])
      end
      
      if params[:min_price].present? && params[:max_price].present?
        catalogues = apply_price_filters(catalogues, params[:min_price], params[:max_price])
      end

      if params[:color_filter].present?
        catalogues = filter_by_colors(catalogues, params[:color_filter])
      end

      per_page = params[:per_page].presence || 50
      page = params[:page].presence || 1

      if params[:sort_by].present?
        catalogues = sort_catalogues(catalogues, params[:sort_by])
      end

      total_count = catalogues.count

      catalogues = paginate_catalogues(catalogues, page, per_page)

      render_search_results(catalogues, min_range, max_range, category&.name, total_count)
    end

# // store menu product list
    def list_store_menu_products
      per_page = params[:per_page].presence&.to_i || 10
      page_number = params[:page].presence&.to_i || 1
      total_count = 0
      @menu = BxBlockStoreManagement::StoreMenu.find_by(id: params[:menu_id])
      if @menu.present?
        store_m_products = @menu.catalogues
        if store_m_products.present?
          total_count = store_m_products.count
          store_m_products = paginate_catalogues(store_m_products, page_number, per_page)
        end
        render json: CatalogueSerializer.new(store_m_products).serializable_hash.merge(total_count: total_count), status: :ok
      else
        render json: { error: "Menu not found" }, status: :unprocessable_entity
      end
    end

    def sku_validate
      sku = params[:sku]

      unless sku
        return render json: {
          message: "SKU parameter is missing"
        }, status: :bad_request
      end

      catalogue = Catalogue.left_joins(:product_variant_groups).where('LOWER(sku) LIKE :query OR LOWER(product_variant_groups.product_sku) LIKE :query', query: sku&.downcase).first

      if catalogue
        return render json: {
          message: "Already exist in database"
        }, status: :conflict
      end

      render json: {
        message: "SKU is valid"
      }, status: :ok
    end

    def update
      return if @catalogue.nil?

      if @catalogue.update(catalogue_params.merge(seller: @seller))
        product_activity_log(@seller, "Product Updated!", "Product #{@catalogue.sku} was updated by #{@seller&.full_name}")
        render json: CatalogueSerializer.new(@catalogue)
        .serializable_hash,
        status: :ok
      else
        render json: { errors: format_activerecord_errors(@catalogue.errors) },
        status: :unprocessable_entity
      end
    end

    def template_download

      category = BxBlockCategories::Category.find_by(id: params[:category_id])
      subcategory = BxBlockCategories::SubCategory.find_by(id: params[:subcategory_id])
      minicategory = BxBlockCategories::MiniCategory.find_by(id: params[:minicategory_id])
      microcategory = BxBlockCategories::MicroCategory.find_by(id: params[:microcategory_id])
      brand = BxBlockCatalogue::Brand.find_by(id: params[:brand_id])
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
      }

      fieldables = [category,subcategory,minicategory,microcategory].compact
      custom_fields = BxBlockCategories::CustomField.where(fieldable: fieldables).order(created_at: :asc)
      custom_fields.each do |custom_field|
        columns_and_values[custom_field.field_name.to_sym] = custom_field.custom_fields_options.map(&:option_name)
      end

      response_data = {
        'headers': columns_and_values.keys.map(&:to_s),
        'values': columns_and_values
      }

      render json: response_data
    end 

    def bulk_upload
      uploaded_file = params[:file]
      return render_invalid_file_format_error unless valid_csv_file?(uploaded_file)

      begin
        spreadsheet = Roo::Spreadsheet.open(uploaded_file.path)
        sheet = spreadsheet.sheet(0)

        if sheet.last_row.nil?
          return render json: { error: 'The uploaded file does not contain any data.' }, status: :unprocessable_entity
        end

        csv_data = sheet.parse(headers: true)

        if csv_data.empty? || csv_data.all?(&:empty?)
          return render json: { error: 'Please upload a file with proper data' }, status: :unprocessable_entity
        end
      rescue => e
        return render json: { error: "The uploaded file contains an invalid format. Error: #{e.message} Please check the file and try again." }, status: :unprocessable_entity
      end

      skipped_rows = []
      validation_errors = []
      successful_rows = []

      csv_data.each_with_index do |row, row_number|
        next if row_number == 0
        
        category_name = row['Category']
        subcategory_name = row['SubCategory']
        minicategory_name = row['MiniCategory']
        microcategory_name = row[MICRO_CATEGORY_COLUMN]
        brand_name = row[BRAND_NAME_COLUMN]

        brand = find_brand(brand_name)

        if brand && check_brand_for_restriction(brand)
          error_message = "Row #{row_number}: The brand '#{brand_name}' you have selected has some restrictions for sellers or distributors,if you have products of the brand, please submit a permit to sell under this brand, and submit a request for approval."
          skipped_rows << error_message
          validation_errors << error_message
          next
        end

        category = find_category(category_name)
        subcategory = find_subcategory(subcategory_name)
        minicategory = find_minicategory(minicategory_name)
        microcategory = find_microcategory(microcategory_name)

        missing_categories = []

        { 'Category' => category, 'Subcategory' => subcategory, 'Minicategory' => minicategory, 'Microcategory' => microcategory, 'Brand' => brand }.each do |name, value|
          missing_categories << name if value.nil?
        end

        if missing_categories.any?
          error_message = "Row #{row_number}: #{missing_categories.join(', ')} not found or created."
          skipped_rows << error_message
          validation_errors << error_message
          next
        end

        create_catalogue(row, row_number, skipped_rows, validation_errors, successful_rows)

      end

      render_upload_result(skipped_rows, validation_errors, successful_rows)
    end

    private

    def load_catalogue
      @catalogue = Catalogue.find_by(id: params[:id])

      if @catalogue.nil?
        render json: {
          message: "Catalogue with id #{params[:id]} doesn't exists"
        }, status: :not_found
      end
    end

    def find_seller
      @seller = AccountBlock::Account.find_by(id: @token.id, user_type: 'seller')
      render json: {errors: 'Seller is invalid'} and return unless @seller
    end

    def catalogue_params
      params.permit(:sku, :besku, :bibc, :product_image, :status, :category_id, :brand_id, :warehouse_id, :product_title, :sub_category_id, :mini_category_id, :micro_category_id, :parent_catalogue_id, :fulfilled_type, :product_type, :content_status, :seller_id)
    end

    def valid_csv_file?(file)
      %w[application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.ms-excel application/x-excel text/csv application/csv].include?(file.content_type) if file
    end

    def create_catalogue(row, row_number, skipped_rows, validation_errors, successful_rows)
      catalog_params = build_catalog_params(row)
      catalogue = Catalogue.new(catalog_params)
      custom_field_error = []
      attach_image_to_catalogue(catalogue, row['Product Image'])
      product_content_params = build_product_content_params(row)
      product_content = catalogue.build_product_content(product_content_params)

      if catalogue.valid? && product_content.valid?
        ActiveRecord::Base.transaction do
          catalogue.save!
          product_content.save!

          process_custom_fields(catalogue, row, row_number, skipped_rows, validation_errors, custom_field_error)
          
          raise ActiveRecord::Rollback unless custom_field_error.blank?
          successful_rows << "Row #{row_number}: Uploaded successfully"
        end
      else
        catalogue_errors = catalogue.errors.full_messages_for(:sku).join(', ').present? && catalogue.errors.full_messages_for(:sku).join(', ') == "Sku has already been taken" ? "SKU / Product is already added" : catalogue.errors.full_messages_for(:sku).join(', ')
        product_image_error = catalogue.errors.full_messages_for(:product_image).join(', ')
        product_content_errors = product_content.errors.full_messages.reject { |error_message| error_message.include?("Unique psku can't be blank") }.join(', ')

        combined_errors = [catalogue_errors, product_image_error, product_content_errors].reject(&:blank?).join(', ')

        skipped_rows << row
        validation_errors << "Row #{row_number}: Validation error(s): #{combined_errors}"
      end
      rescue StandardError => e
        skipped_rows << row
        validation_errors << "Row #{row_number}: Error(s): #{e.message}"
    end

    def process_custom_fields(catalogue, row, row_number, skipped_rows, validation_errors, custom_field_error)
      fieldables = [catalogue.category, catalogue.sub_category, catalogue.mini_category, catalogue.micro_category].compact
      custom_fields = BxBlockCategories::CustomField.where(fieldable: fieldables)
      custom_fields.each do |custom_field|
        if custom_field.mandatory? && row[custom_field.field_name].blank?
          error_var = "Row #{row_number}: Mandatory field '#{custom_field.field_name}' is missing"
          skipped_rows << row
          custom_field_error << error_var
          validation_errors << error_var
        end
        content = catalogue.catalogue_contents.find_by(custom_field_id: custom_field.id)
        if content.present? && row[custom_field.field_name].present?
          value = row[custom_field.field_name].strip
          allowed_options = custom_field.custom_fields_options.pluck(:option_name)

          if !value.in?(allowed_options)
            error_var = "Row #{row_number}: Value '#{value}' for custom field '#{custom_field.field_name}' is not valid. Allowed values are: #{allowed_options.join(', ')}"
            skipped_rows << row
            custom_field_error << error_var
            validation_errors << error_var
          else
            content.value = value
            content.save!
          end
        end
      end
    end

    def check_brand_for_restriction(brand)
      brand.restricted && brand.account != @seller && brand.restricted_brands.where(seller_id: @seller.id, approved: true).empty?
    end

    def build_catalog_params(row)
      {
        category: find_category(row['Category']),
        sub_category: find_subcategory(row['SubCategory']),
        mini_category: find_minicategory(row['MiniCategory']),
        micro_category: find_microcategory(row[MICRO_CATEGORY_COLUMN]),
        brand: find_brand(row[BRAND_NAME_COLUMN]),
        sku: row['Seller SKU']&.strip,
        seller: @seller,
        product_title: row['Product Title']&.strip
      }
    end

    def attach_image_to_catalogue(catalogue, image_url)
      return if image_url.blank?

      begin
        image_file = URI.open(image_url)
        catalogue.product_image.attach(io: image_file, filename: File.basename(image_url))
      rescue OpenURI::HTTPError, SocketError => e
        catalogue.errors.add(:product_image, "could not be attached: #{e.message}")
      end
    end

    def build_product_content_params(row)
      size_and_capacity_params = {
        size: row['Size'],
        size_unit: row['Size Unit'],
        capacity: row['Capacity'],
        capacity_unit: row['Capacity Unit'],
        hs_code: row['HS Code'].present? ? row['HS Code'].to_i.to_s : nil,
        prod_model_name: row['Prod Model Name'],
        prod_model_number: row['Prod Model Number'],
        number_of_pieces: row['Number of Pieces']
      }

      shipping_detail_params = {
        shipping_length: row['Shipping Length'],
        shipping_length_unit: row['Shipping Length Unit'],
        shipping_height: row['Shipping Height'],
        shipping_height_unit: row['Shipping Height Unit'],
        shipping_width: row['Shipping Width'],
        shipping_width_unit: row['Shipping Width Unit'],
        shipping_weight: row['Shipping Weight'],
        shipping_weight_unit: row['Shipping Weight Unit']
      }

      params_hash = {
        gtin: row['GTIN']&.to_i&.to_s,
        unique_psku: row['Seller SKU']&.strip,
        brand_name: row['Brand Name']&.strip,
        product_title: row['Product Title']&.strip,
        mrp: row['MRP'],
        retail_price: row['Retail Price'],
        warranty_days: row['Warranty Days'],
        warranty_months: row['Warranty Months'],
        long_description: row['Long Description'],
        whats_in_the_package: row['Whats in the Package'],
        country_of_origin: row['Country of Origin'],
        product_color: row['Product Color'],
        image_urls: build_image_urls_params(row), 
        feature_bullets: build_feature_bullets_params(row)
        }

        params_hash[:size_and_capacity] = BxBlockCatalogue::SizeAndCapacity.new(size_and_capacity_params) if size_and_capacity_params.values.any?(&:present?)
        params_hash[:shipping_detail] = BxBlockCatalogue::ShippingDetail.new(shipping_detail_params) if shipping_detail_params.values.any?(&:present?)

        params_hash
      end

    def build_feature_bullets_params(row)
      feature_bullets = []

      (1..5).each do |bullet_number|
        bullet_key = "Feature Bullet #{bullet_number}"
        bullet_value = row[bullet_key]

        if bullet_value.present?
          feature_bullets << BxBlockCatalogue::FeatureBullet.new(
            field_name: bullet_key,
            value: bullet_value
            )
        end
      end

      feature_bullets
    end

    def build_image_urls_params(row)
      image_urls = []

      (1..6).each do |image_no|
        image_key = "Image URL #{image_no}"
        image_value = row[image_key]

        if image_value.present?
          image_urls << BxBlockCatalogue::ImageUrl.new(
            url: image_value
            )
        end
      end

      image_urls
    end

    def render_upload_result(skipped_rows, validation_errors, successful_rows)
      bulk_upload_logs(skipped_rows, validation_errors, successful_rows)
      if skipped_rows.empty?
        render json: { message: 'Bulk upload completed successfully', successful_rows: successful_rows }, status: :ok
      else
        render json: { message: 'Bulk upload completed with errors', skipped_rows: skipped_rows, successful_rows: successful_rows, validation_errors: validation_errors }, status: :unprocessable_entity
      end
    end

    def bulk_upload_logs(skipped_rows, validation_errors, successful_rows)
      details = "Message: 'Bulk upload completed'\n" \
            "Successful Rows: #{successful_rows}\n" \
            "Skipped Rows: #{skipped_rows}\n" \
            "Validation Errors: #{validation_errors}"

      product_activity_log(@seller, "Bulk Products Uploaded", details)
    end

    def render_invalid_file_format_error
      render json: { error: 'Invalid file format' }, status: :unprocessable_entity
    end

    def check_favourite_for_buyer(catalogue, params)
      user = AccountBlock::Account.buyer_accounts.find_by(id: params[:account_id])

      if user.present?
        favourite = user.favourites.find_by(favouriteable_id: catalogue&.id, product_variant_group_id: params[:product_variant_group_id].presence)

        if favourite.present?
          return {
            id: favourite.id,
            favouriteable_id: favourite.favouriteable_id,
            favouriteable_type: favourite.favouriteable_type,
            user_id: favourite.user_id,
            product_variant_group_id: favourite.product_variant_group_id,
            wishlist: true
          }
        end
      end

      { wishlist: false }
    end

    def product_activity_log(user, message, details)
      BxBlockActivitylog::ActivityLog.create(
        user: @seller,
        action: message,
        details: details,
        accessed_at: Time.current
        )
    end

  end
end
