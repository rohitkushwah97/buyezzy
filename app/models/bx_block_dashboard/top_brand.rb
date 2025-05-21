module BxBlockDashboard
	class TopBrand < ApplicationRecord
		self.table_name = :top_brands

		belongs_to :brand, class_name: "BxBlockCatalogue::Brand"

		validates :sequence_no, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 6 }
	end
end