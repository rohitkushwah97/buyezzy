module BxBlockCatalogue
	class RestrictedBrand < ApplicationRecord
		self.table_name = :restricted_brands
		belongs_to :brand, class_name: "BxBlockCatalogue::Brand"
		belongs_to :seller, class_name: "AccountBlock::Account"

		has_one_attached :reseller_permit_document

		validates :reseller_permit_document ,presence: true
	end
end