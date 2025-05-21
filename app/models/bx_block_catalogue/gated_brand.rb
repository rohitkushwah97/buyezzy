module BxBlockCatalogue
	class GatedBrand < ApplicationRecord
		self.table_name = :gated_brands
		belongs_to :brand, class_name: "BxBlockCatalogue::Brand"
		
		has_one_attached :reseller_permit_document, dependent: :destroy

	end
end

