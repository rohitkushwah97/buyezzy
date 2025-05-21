module BxBlockCatalogue
	class CatalogueContent < ApplicationRecord
		self.table_name = :catalogue_contents
		belongs_to :custom_field, class_name: "BxBlockCategories::CustomField", optional: true
		belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue"
		validates :value, allow_blank: true, length: { in: 3..30 }
	end
end