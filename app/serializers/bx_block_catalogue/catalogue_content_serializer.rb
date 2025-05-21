module BxBlockCatalogue
	class CatalogueContentSerializer < BuilderBase::BaseSerializer
		attributes  :id, :custom_field_name, :value, :custom_field_id, :catalogue_id, :status

		# attributes :catalogue do |object|
		# 	if object.catalogue
		# 		object.catalogue.serializable_hash(only: [:id, :sku, :besku])
		# 	end
		# end

		attributes :custom_field_detail do |object|
			if object.custom_field
				BxBlockCategories::CustomFieldSerializer.new(object.custom_field)
			end
		end

	end
end
