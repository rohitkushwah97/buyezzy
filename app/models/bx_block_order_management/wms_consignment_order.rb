module BxBlockOrderManagement
	class WmsConsignmentOrder < ApplicationRecord
		self.table_name = :wms_consignment_orders
		belongs_to :seller, class_name: "AccountBlock::Account"
		belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue"
	end
end