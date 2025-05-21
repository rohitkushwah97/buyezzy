module BxBlockDashboard
	class TrendingProductSelection < ApplicationRecord
		self.table_name = :trending_product_selections
		
		belongs_to :trending_product, class_name: "BxBlockDashboard::TrendingProduct"
		belongs_to :catalogue, class_name: 'BxBlockCatalogue::Catalogue'
	end
end