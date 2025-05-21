module BxBlockCatalogue
  class ProductContentSerializer < BuilderBase::BaseSerializer
    attributes :id, :catalogue_id, :gtin, :unique_psku, :brand_name, :product_title, :mrp, :retail_price, :long_description, :whats_in_the_package, :country_of_origin, :product_color, :warranty_days, :warranty_months, :dispenser_type, :scent_type, :target_use, :style_name

    attribute :size_and_capacity do |object|
      object.size_and_capacity&.serializable_hash(only: [:id, :size, :size_unit, :capacity, :capacity_unit, :hs_code, :prod_model_name, :prod_model_number, :number_of_pieces])
    end

    attribute :shipping_detail do |object|
      object.shipping_detail&.serializable_hash(only: [:id, :shipping_length, :shipping_length_unit, :shipping_height, :shipping_height_unit, :shipping_width, :shipping_width_unit, :shipping_weight, :shipping_weight_unit])
    end

    attribute :image_urls do |object|
      object.image_urls&.map {|image| image.serializable_hash(only: [:id, :url])}
    end

    attribute :feature_bullets do |object|
      object.feature_bullets&.map { |bullet| bullet.serializable_hash(only: [:id, :field_name, :value]) }
    end

    attributes :custom_fields_contents do |object|
      object.catalogue.catalogue_contents.order(created_at: :asc)&.map {|content| content.serializable_hash(only: [:id, :custom_field_name, :value,:custom_field_id, :catalogue_id] ) }
    end

    attribute :special_features do |object|
      object.special_features&.map { |feature| feature.serializable_hash(only: [:id, :field_name, :value]) }
    end
  end
end
