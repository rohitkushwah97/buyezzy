module BxBlockCatalogue
  class ProductVariantGroupSerializer < BuilderBase::BaseSerializer
    attributes :id,:catalogue_variant_id, :catalogue_id, :variant_product_id, :product_sku,:product_besku, :product_bibc, :product_description, :price, :product_title, :created_at, :updated_at

    attributes :group_attributes do |object|
      if object.group_attributes
        object.group_attributes.group_by(&:attribute_name).map do |attribute_name, groups|
          {
            attribute_name: attribute_name,
            options: groups.map(&:option)
          }
        end
      end
    end

    attributes :individual_group_attr_with_ids do |object|
      if object.group_attributes
        object.group_attributes.order(created_at: :desc).map do |group|
          {
            id: group.id,
            attribute_name: group.attribute_name,
            options: group.option,
            variant_attribute_id: group.variant_attribute_id,
            attribute_option_id: group.attribute_option_id
          }
        end
      end
    end

    attribute :variant_product do |object|
      BxBlockCatalogue::CatalogueSerializer.new(object.variant_product)
    end

    attribute :catalogue do |object|
      BxBlockCatalogue::CatalogueSerializer.new(object.catalogue)
    end

    attribute :catalogue_variant do |object|
      BxBlockCatalogue::CatalogueVariantSerializer.new(object.catalogue_variant)
    end

  end
end
