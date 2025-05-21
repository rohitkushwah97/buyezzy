module BxBlockCatalogue
	class Barcode < ApplicationRecord
		self.table_name = :barcodes
		
		belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue"
		validates :bar_code, presence: true
		has_one :catalogue_offer, class_name: "BxBlockCatalogue::CatalogueOffer", dependent: :destroy
	end
end