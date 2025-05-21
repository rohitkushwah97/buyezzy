module BxBlockOrderManagement
	class WmsProductInfo < ApplicationRecord
		self.table_name = :wms_product_infos
		belongs_to :seller, class_name: "AccountBlock::Account"
		belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue"
	end
end