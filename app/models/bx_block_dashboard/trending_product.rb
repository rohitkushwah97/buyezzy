module BxBlockDashboard
	class TrendingProduct < ApplicationRecord
		self.table_name = :trending_products
		enum slider: {
			slider_1: 1,
			slider_2: 2
		}
		has_many :trending_product_selections, class_name: "BxBlockDashboard::TrendingProductSelection", dependent: :destroy
		has_many :catalogues, through: :trending_product_selections, class_name: "BxBlockCatalogue::Catalogue"

		accepts_nested_attributes_for :trending_product_selections, allow_destroy: true
		has_one_attached :sale_ad_image, dependent: :destroy
		validates :slider, presence: true, uniqueness: true
		validates :sale_ad_image, presence: true
		validate :minimum_6_products

		private

		def minimum_6_products
			selections = trending_product_selections.reject { |s| s.marked_for_destruction? }
			errors.add(:trending_product_selections, "must have at least 6 unique products") if selections.size < 6

			product_ids = selections.map(&:catalogue_id)
			errors.add(:trending_product_selections, "cannot have duplicate products") if product_ids.uniq.size != product_ids.size
		end
	end
end