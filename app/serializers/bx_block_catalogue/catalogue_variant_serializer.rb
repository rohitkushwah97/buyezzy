module BxBlockCatalogue
  class CatalogueVariantSerializer < BuilderBase::BaseSerializer
    attributes :id, :seller_id,:micro_category_id, :group_name, :created_at, :updated_at

    attributes :variant_attributes do |object|
      if object.variant_attributes
        object.variant_attributes.order(created_at: :desc).map do |var_attr|
          {
            id: var_attr.id,
            attribute_name: var_attr.attribute_name,
            attribute_options: var_attr.attribute_options.order(created_at: :desc)&.map do |attr_option|
              {
                id: attr_option.id,
                option: attr_option.option
              }
            end
          }
        end
      end
    end

    attributes :micro_category do |object|
      BxBlockCategories::MicroCategorySerializer.new(object.micro_category)
    end
  end
end
