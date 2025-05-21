module BxBlockCatalogue
  class CatalogueSerializer < BuilderBase::BaseSerializer
    attributes :id, :category_id, :brand_id, :parent_catalogue_id, :warehouse_id, :seller_id ,:sku,:besku, :bibc,:product_title, :is_variant, :fulfilled_type, :product_type, :purchased_count,:recommended_priority, :stocks, :content_status, :status, :stroked_price, :offer_percentage

    attributes :product_image do |object|
      if object.product_image.attached?
        ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.product_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.product_image, only_path: true)
      end
    end

    attributes :created_at,:updated_at

    attributes :final_price do |object|
      object.calculate_effective_price.to_s
    end

    attributes :category do |object|
      if object.category
        object.category.serializable_hash(only: [:id, :name])
      end
    end

    attributes :sub_category do |object|
      if object.sub_category
        object.sub_category.serializable_hash(only: [:id, :name])
      end
    end

    attributes :mini_category do |object|
      if object.mini_category
        object.mini_category.serializable_hash(only: [:id, :name])
      end
    end

    attributes :micro_category do |object|
      if object.micro_category
        object.micro_category.serializable_hash(only: [:id, :name])
      end
    end

    attributes :brand do |object|
      if object.brand
        {
          id: object.brand.id,
          brand_name: object.brand.brand_name,
          store: store_details(object.brand.store)
        }
      end
    end

    attributes :product_rating do |object|
      reviews = object.review_and_ratings.approved_reviews.where(review_type: 'product')
      total_count = reviews.count
      if reviews.present?
        {
          average_rating: average_rating(reviews).round(1),
          total_reviews: total_count
        }
      end
    end

    attributes :product_content do |object|
      if object.product_content
        product_content = object.product_content
        {
          product_attributes: product_content&.serializable_hash(only: [:id, :catalogue_id, :gtin, :unique_psku, :brand_name, :product_title, :mrp, :retail_price, :long_description, :whats_in_the_package, :country_of_origin, :product_color, :warranty_days, :warranty_months]),
          size_and_capacity: product_content.size_and_capacity&.serializable_hash(only: [:size, :size_unit, :capacity, :capacity_unit, :hs_code, :prod_model_name, :prod_model_number, :number_of_pieces]),
          shipping_detail: product_content.shipping_detail&.serializable_hash(only: [:shipping_length, :shipping_length_unit, :shipping_height, :shipping_height_unit, :shipping_width, :shipping_width_unit, :shipping_weight, :shipping_weight_unit]),
          image_urls: image_urls(object, product_content),
          feature_bullets: product_content.feature_bullets&.map { |bullet| bullet.serializable_hash(only: [:field_name, :value]) },
          custom_fields_contents: object.catalogue_contents.map {|content| content.serializable_hash(only: [:id, :custom_field_name, :value,:custom_field_id, :catalogue_id] ) }
          # special_features: product_content.special_features&.map { |feature| feature.serializable_hash(only: [:field_name, :value]) }
        }
      end
    end

    attributes :catalogue_offer do |object|
      if object.catalogue_offer
        object.catalogue_offer.serializable_hash(only: [:id, :price_info, :sale_price, :bar_code_info, :sale_schedule_from, :sale_schedule_to, :warranty, :comments, :status])
      end
    end

    attributes :barcode do |object|
      if object.barcode
        object.barcode.serializable_hash(only: [:id, :bar_code])
      end
    end

    attributes :deals do |object|
      if object.deals
        object.deals&.map { |deal| deal.serializable_hash(only: [:id, :deal_name, :deal_code,:discount_type,:discount_value, :start_date, :end_date, :status]) }
      end
    end

    attributes :deal_catalogues do |object|
      if object.deal_catalogues
        object.deal_catalogues&.map { |seller_deal| seller_deal.serializable_hash(only: [:id, :deal_id, :catalogue_id,:seller_id, :seller_sku, :product_title, :seller_price, :current_offer_price, :deal_price, :status]) }
      end
    end

    attributes :warehouses do |object|
      if object.warehouses
        object.warehouses.map {|warehouse| warehouse.serializable_hash(only: [:id, :warehouse_name]) }
      end
    end

    attributes :warehouse_catalogues do |object|
       object.warehouse_catalogues.map { |war_cat| war_cat.serializable_hash(only: [:id, :warehouse_id, :product_variant_group_id, :catalogue_id, :stocks]) }
    end

    attribute :seller do |object|
      if object.seller
        AccountBlock::AccountSerializer.new(object.seller)
      end
    end

    attributes :product_variant_groups do |object|
      if object&.product_variant_groups&.present?
        object&.product_variant_groups&.map do |prod_variant|
          {
            id: prod_variant&.id,
            product_sku: prod_variant&.product_sku,
            product_besku: prod_variant&.product_besku,
            product_bibc: prod_variant&.product_bibc,
            group_attributes: prod_variant&.group_attributes&.group_by(&:attribute_name).map do |attribute_name, groups|
              {
                attribute_name: attribute_name,
                options: groups.map(&:option)
              }
            end
          }
        end
      end
    end

    attributes :variant_products do |object|
        CatalogueSerializer.new(object.variant_products)
    end

    attributes :variant_product_group do |object|
      prod_variant = object.product_variant_group
      if prod_variant
        {
          id: prod_variant.id,
          product_sku: prod_variant.product_sku,
          product_besku: prod_variant.product_besku,
          product_bibc: prod_variant&.product_bibc,
          group_attributes: prod_variant.group_attributes.order(created_at: :desc).map do |group|
            {
              id: group.id,
              attribute_name: group.attribute_name,
              options: group.option,
              variant_attribute_id: group.variant_attribute_id,
              attribute_option_id: group.attribute_option_id
            }
          end
        }
      end
    end

    def self.image_urls(object, product_content)
      image_urls = [object.product_image.attached? ? (ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.product_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.product_image, only_path: true)) : nil] + (product_content.image_urls&.map(&:url) || [])
      image_urls.compact
    end

    def self.average_rating(reviews)
      total_reviews = reviews.count
      return 0 if total_reviews.zero?

      total_rating = reviews.sum(&:rating)
      total_rating.to_f / total_reviews
    end

    def self.store_details(store)
      return unless store

      {
        id: store.id,
        store_name: store.store_name,
        store_year: store.store_year,
        store_url: store.store_url,
        website_social_url: store.website_social_url,
        approve: store.approve
      }
    end

  end
end
