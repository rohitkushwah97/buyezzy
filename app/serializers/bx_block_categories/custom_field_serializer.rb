module BxBlockCategories
  class CustomFieldSerializer < BuilderBase::BaseSerializer
    attributes :field_name, :mandatory

    attributes :custom_fields_options do |object|
        object.custom_fields_options.map(&:option_name)
    end

    attribute :category do |object|
        object.fieldable if object.fieldable_type == "BxBlockCategories::Category"
    end

    attribute :sub_category do |object|
        object.fieldable if object.fieldable_type == "BxBlockCategories::SubCategory"
    end

    attribute :mini_category do |object|
        object.fieldable if object.fieldable_type == "BxBlockCategories::MiniCategory"
    end

    attribute :micro_category do |object|
        object.fieldable if object.fieldable_type == "BxBlockCategories::MicroCategory"
    end

  end
end
