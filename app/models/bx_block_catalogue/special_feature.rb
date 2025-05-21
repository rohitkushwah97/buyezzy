module BxBlockCatalogue
	class SpecialFeature < ApplicationRecord
		self.table_name = :special_features
		
		belongs_to :product_content, class_name: "BxBlockCatalogue::ProductContent"

		validates :value, presence:true
	end
end