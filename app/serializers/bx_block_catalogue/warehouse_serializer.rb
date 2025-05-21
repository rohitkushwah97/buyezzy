module BxBlockCatalogue
	class WarehouseSerializer < BuilderBase::BaseSerializer
	 	attributes :id, :warehouse_name, :warehouse_address_1,:warehouse_address_2, :contact_number, :contact_person, :processing_days, :account_id, :created_at, :updated_at

	 	attribute :seller do |object|
	 		AccountBlock::AccountSerializer.new(object.account)
	 	end 

	 	attributes :stock_logs do |object|
	 		if object.warehouse_catalogues
	 			WarehouseCatalogueSerializer.new(object.warehouse_catalogues)
	 		end
	 	end

	 	attributes :product_variant_groups do |object|
	 		if object.product_variant_groups
	 			object.product_variant_groups.map do |product_variant_group|
	 				{
	 					id: product_variant_group.id,
	 					catalogue_id: product_variant_group.catalogue_id,
	 					product_sku: product_variant_group.product_sku,
	 					product_besku: product_variant_group.product_besku,
	 					group_attributes: product_variant_group.group_attributes&.group_by(&:attribute_name).map do |attribute_name, groups|
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
end