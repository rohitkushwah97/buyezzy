module BxBlockDashboard
	class HeaderCategory < ApplicationRecord
		self.table_name = :header_categories
		belongs_to :category, class_name: "BxBlockCategories::Category"
		validates :sequence_no, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 6 }
	end
end