module BxBlockCatalogue
	class CatalogueOffer < ApplicationRecord
		self.table_name = :catalogue_offers
		belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue"
		belongs_to :barcode, class_name: "BxBlockCatalogue::Barcode", foreign_key: "barcode_id", optional: true
		validate :validate_exist_deals, if: -> { status }

		after_save :update_catalogue_final_price
		after_destroy :update_catalogue_final_price

		after_save :update_deal_seller_price, if: :saved_change_to_sale_price?

		after_commit :schedule_expiry_job, if: -> { active? }

		def active?
			status && sale_schedule_to.present? && sale_schedule_to >= Date.today && sale_schedule_from <= Date.today
		end

		def update_catalogue_final_price
			catalogue.update_columns(
				final_price: catalogue.calculate_effective_price,
				offer_percentage: catalogue.calculate_offer_percentage,
				stroked_price: catalogue.calculate_stroked_price
				) if catalogue.present?
		end

		private

		def schedule_expiry_job
			ExpireOffersAndDealsJob.set(wait_until: sale_schedule_to.to_time).perform_later
		end

		def update_deal_seller_price
			return unless catalogue.deal_catalogues.present?

			catalogue.deal_catalogues.update_all(seller_price: sale_price)
		end

		def validate_exist_deals	
			if catalogue.deal_catalogues.where(status: [:review, :approved]).any? { |deal_cat| deal_cat.deal.active? }
				errors.add(:catalogue, "Cannot create an active offer as there is an active and approved deal for this product.")
			end
		end
	end
end