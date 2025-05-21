module BxBlockFavourites
  class FavouriteSerializer < BuilderBase::BaseSerializer
    attributes *[
      :favouriteable_id,
      :favouriteable_type,
      :user_id,
      :created_at,
      :updated_at,
    ]

    attributes :catalogue do |object|
      if object.favouriteable.is_a?(BxBlockCatalogue::Catalogue)
        BxBlockCatalogue::CatalogueSerializer.new(object.favouriteable).serializable_hash
      end
    end

    attribute :selected_product_variant do |object|
       if object.product_variant_group.present?
          {
              id: object.product_variant_group.id,
              product_sku: object.product_variant_group.product_sku,
              product_besku: object.product_variant_group.product_besku,
              product_description: object.product_variant_group.product_description,
              price: object.product_variant_group.price,
              product_title: object.product_variant_group.product_title,
              product_images: object.product_variant_group.product_images.attached? ? object.product_variant_group.product_images.map { |image| "#{ENV['BASE_URL']}#{Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)}" } : nil,
              group_attributes: object.product_variant_group.group_attributes&.group_by(&:attribute_name).map do |attribute_name, groups|
                {
                  attribute_name: attribute_name,
                  options: groups.map(&:option)
                }
              end
          }
        end
      end
  end
end
