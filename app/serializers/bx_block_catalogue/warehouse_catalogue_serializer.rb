module BxBlockCatalogue
	class WarehouseCatalogueSerializer < BuilderBase::BaseSerializer
	 	attributes :id, :warehouse_id, :product_variant_group_id, :catalogue_id, :stocks, :created_at, :updated_at

	 	attributes :catalogue do |object|
	 		if object.catalogue
	 			CatalogueSerializer.new(object.catalogue)
	 		end
	 	end

	 	attribute :selected_product_variant do |object|
	 		if object.product_variant_group.present?
	 			{
	 				id: object.product_variant_group.id,
	 				product_sku: object.product_variant_group.product_sku,
	 				product_besku: object.product_variant_group.product_besku,
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