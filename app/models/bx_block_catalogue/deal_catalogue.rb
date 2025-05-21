module BxBlockCatalogue
	class DealCatalogue < ApplicationRecord
		self.table_name = :deal_catalogues
		belongs_to :deal, class_name: "BxBlockCatalogue::Deal"
		belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue"
		belongs_to :seller, class_name: "AccountBlock::Account"

		validates :deal_price, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: -> { deal&.discount_type == "flat" }

		enum status: { review: 0, approved: 1, rejected: 2, expired: 3 }
		before_create :set_deal_price_and_offer_price

		before_save :update_catalogue_details

		before_update :set_deal_price_and_offer_price, unless: -> { deal_price_changed? }

		validate :deal_exists_and_approved_or_review, unless: :can_be_updated?

		after_save :update_catalogue_final_price
		after_destroy :update_catalogue_final_price

		def update_catalogue_final_price
			catalogue.update_columns(
				final_price: catalogue.calculate_effective_price,
				offer_percentage: catalogue.calculate_offer_percentage,
				stroked_price: catalogue.calculate_stroked_price
				) if catalogue.present?
		end

		attr_accessor :skip_deal_price_callback

		private

		def can_be_updated?
			expired? || rejected?
		end

		def deal_exists_and_approved_or_review
			if catalogue
				existing_deal_catalogues = catalogue.deal_catalogues.where.not(id: id).where(status: [:review, :approved])

				deal_active = existing_deal_catalogues.any? { |deal_cat| deal_cat.deal.active? }

				offer_active = catalogue.catalogue_offer&.active?

				if deal_active || offer_active
					errors.add(:catalogue, "A deal for this product already exists and is either in review, approved, or there is an active offer.")
				end
			end
		end

		def update_catalogue_details
			catalogue = self.catalogue

			self.seller_sku = catalogue.is_variant ? catalogue.product_variant_group&.product_sku : catalogue.sku
			self.product_title = catalogue.product_content&.product_title
			self.seller_price = catalogue.product_content&.retail_price
			self.current_offer_price = catalogue.catalogue_offer&.sale_price || 0.0
		end

		def set_deal_price_and_offer_price
			if deal.active? && deal.discount_value.present?
				if deal.discount_type == "flat"
					set_deal_price

				elsif deal.discount_type == "percentage"
					set_current_offer_price
				else
					nil
				end
			end
		end

		def set_current_offer_price
			cprice = catalogue.product_content&.retail_price || 0.0
			percentage_discount = deal.discount_value.to_f / 100.0
			discount_amount = cprice * percentage_discount
			price = cprice - discount_amount
			self.deal_price = price
		end

		def set_deal_price
			dprice = catalogue.product_content&.retail_price || 0.0
			discounted_price = (dprice - deal.discount_value).round(2)
			self.deal_price = [discounted_price, 0.0].max
		end

	end
end
