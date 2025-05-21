module BxBlockDashboard
	class MostPopularCategory < ApplicationRecord
		self.table_name = :most_popular_categories
		belongs_to :category, class_name: "BxBlockCategories::Category"

		validates :sequence_no, presence: true, uniqueness: true, numericality: { only_integer: true,greater_than_or_equal_to: 1, less_than_or_equal_to: 6 }
	end
end