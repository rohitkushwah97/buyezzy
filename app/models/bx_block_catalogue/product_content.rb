# // This model also for the content tab of product, added because change in functionality, also there is another model catalogue content which created before this and its becasue of custom fields, if needed we can use
module BxBlockCatalogue
	class ProductContent < ApplicationRecord
		self.table_name = :product_contents

		PRODUCT_COLORS = ["Purple", "Light Coral","Lime Green", "Yellow", "Grey", "Ocean Green", "Pink", "Sky blue"]

		belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue"
		has_one :size_and_capacity, class_name: "BxBlockCatalogue::SizeAndCapacity", dependent: :destroy
		has_one :shipping_detail, class_name: "BxBlockCatalogue::ShippingDetail", dependent: :destroy
		has_many :image_urls, class_name: "BxBlockCatalogue::ImageUrl", dependent: :destroy
		has_many :feature_bullets, class_name: "BxBlockCatalogue::FeatureBullet", dependent: :destroy
		has_many :special_features, class_name: "BxBlockCatalogue::SpecialFeature", dependent: :destroy
		accepts_nested_attributes_for :feature_bullets, :image_urls, :special_features, :shipping_detail, :size_and_capacity, allow_destroy: true
		validates :mrp, :retail_price, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
		validates :brand_name, :product_title, :retail_price, :whats_in_the_package, :country_of_origin, :long_description,:product_color, presence: true
		validates :unique_psku, presence: true, uniqueness: { scope: :catalogue_id }, if: -> { catalogue&.parent_product_id.nil? }
		validates :unique_psku, presence: true, if: -> { catalogue&.is_variant? }
		validates :gtin, length: { in: 8..14 }, numericality: { only_integer: true }, uniqueness: true, allow_blank: true
		validates :warranty_days, :warranty_months, numericality: { only_integer: true, less_than_or_equal_to: 999, message: "must be integer and no more than 3 digits" }, allow_nil: true
		validate :validate_matching_sku
		validate :validate_presence_of_feature_bullets_and_image_urls
		validate :validate_country_of_origin, if: -> { country_of_origin.present? }
		validate :validate_product_color, if: -> { product_color.present? }

		before_save :update_product_title
		after_save :update_deal_seller_price, if: :saved_change_to_retail_price?

		private

		def update_deal_seller_price
			return unless catalogue.deal_catalogues.present?

			catalogue.deal_catalogues.update_all(seller_price: retail_price)
		end

		def validate_country_of_origin
			countries_name = CS.countries.values.map(&:downcase)
			unless countries_name.include?(country_of_origin.downcase)
				errors.add(:country_of_origin, "is not a valid country")
			end
		end

		def validate_product_color
			product_colors = PRODUCT_COLORS.map(&:downcase)
			unless product_colors.include?(product_color.downcase)
				errors.add(:product_color, "is not a valid product color")
			end
		end

		def validate_presence_of_feature_bullets_and_image_urls
			if feature_bullets.empty?
				errors.add(:feature_bullets, "At least one feature bullet must be present")
			end

			if image_urls.empty?
				errors.add(:image_urls, "At least one image URL must be present")
			end
		end

		def validate_matching_sku
			unless catalogue && unique_psku == catalogue.sku
				errors.add(:unique_psku, "must match the SKU of the associated catalogue")
			end
		end

		def update_product_title
			if catalogue&.product_title.present? && product_title.blank?
				self.product_title = catalogue.product_title
			elsif catalogue.present? && catalogue.product_title != product_title
				catalogue.update(product_title: product_title)
			end

			# added for price update
			catalogue.update_columns(
					final_price: catalogue.calculate_effective_price,
					offer_percentage: catalogue.calculate_offer_percentage,
					stroked_price: catalogue.calculate_stroked_price
					) if catalogue.present?
		end

	end
end