module BxBlockCatalogue
	class FeatureBullet < ApplicationRecord
		self.table_name = :feature_bullets
		
		belongs_to :product_content, class_name: "BxBlockCatalogue::ProductContent"

		validates :value, presence:true
	end
end