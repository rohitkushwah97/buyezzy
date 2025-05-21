module BxBlockDashboard
	class WeeklyDeal < ApplicationRecord
		self.table_name = :weekly_deals
		belongs_to :weekly_homiee_deal, class_name: "BxBlockDashboard::WeeklyHomieeDeal"
		belongs_to :deal, class_name: "BxBlockCatalogue::Deal"

		has_one_attached :bg_image, dependent: :destroy

		validates :caption, :bg_image, presence: true
		# validates :url, presence: true, format: { with: /\A(?:https:\/\/|www\.)/, message: "should start with 'https://' or 'www.'" }
		validates :discount_percent, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

	end
end