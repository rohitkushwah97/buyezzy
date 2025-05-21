module BxBlockCatalogue
	class ProductVariantGroup < ApplicationRecord
		self.table_name = :product_variant_groups
		belongs_to :catalogue_variant, class_name: "BxBlockCatalogue::CatalogueVariant", optional: true, foreign_key: "catalogue_variant_id"
		belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue"
		belongs_to :variant_product, class_name: "BxBlockCatalogue::Catalogue", optional: true, foreign_key: "variant_product_id", dependent: :destroy
		has_many :group_attributes, class_name: "BxBlockCatalogue::GroupAttribute", dependent: :destroy
		has_many :order_items, class_name: "BxBlockShoppingCart::OrderItem", dependent: :destroy
		has_many :favourites, class_name: "BxBlockFavourites::Favourite", dependent: :destroy
		has_many :warehouse_catalogues, class_name: "BxBlockCatalogue::WarehouseCatalogue", dependent: :destroy
		has_many :warehouses, through: :warehouse_catalogues
		
		accepts_nested_attributes_for :group_attributes, allow_destroy: true

		has_many_attached :product_images, dependent: :destroy
		validates :product_sku, presence: true
		validate :unique_product_sku_across_catalogues_and_groups
		before_save :create_besku

		def create_and_associate_variant_product
			BxBlockCatalogue::Catalogue.transaction do
				variant_product = BxBlockCatalogue::Catalogue.new(
					catalogue_attributes.merge(
						parent_product: catalogue,
						is_variant: true,
						product_content_attributes: product_content_attributes
						)
					)
				
				if catalogue.product_image.attached?
					variant_product.product_image.attach(catalogue.product_image.blob)
				end
				
				variant_product.save!
				Rails.logger.debug("Variant product created: #{variant_product.inspect}")

				update!(variant_product: variant_product)
				Rails.logger.debug("ProductVariantGroup updated with variant_product: #{variant_product.inspect}")
			end
		rescue StandardError => e
			Rails.logger.error("Error creating and associating variant product: #{e.message}")
			raise e
		end

		def catalogue_attributes
			catalogue.attributes.except("id", "created_at", "updated_at", "is_variant", "purchased_count", "stocks", "status", "content_status", "parent_catalogue_id")
		end

		def product_content_attributes
			return {} unless catalogue.product_content

			product_content_attr = catalogue.product_content.attributes.except("id", "catalogue_id", "created_at", "updated_at", "gtin")
			product_content_attr.merge!(
				size_and_capacity_attributes: size_and_capacity_attributes,
				shipping_detail_attributes: shipping_detail_attributes,
				image_urls_attributes: image_urls_attributes,
				feature_bullets_attributes: feature_bullets_attributes
				)
		end

		def size_and_capacity_attributes
			return {} unless catalogue.product_content&.size_and_capacity

			catalogue.product_content.size_and_capacity.attributes.except("id", "product_content_id", "created_at", "updated_at")
		end

		def shipping_detail_attributes
			return {} unless catalogue.product_content&.shipping_detail

			catalogue.product_content.shipping_detail.attributes.except("id", "product_content_id", "created_at", "updated_at")
		end

		def image_urls_attributes
			return [] unless catalogue.product_content&.image_urls

			catalogue.product_content.image_urls.map { |image_url| image_url.attributes.except("id", "product_content_id", "created_at", "updated_at") }
		end

		def feature_bullets_attributes
			return [] unless catalogue.product_content&.feature_bullets

			catalogue.product_content.feature_bullets.map { |bullet| bullet.attributes.except("id", "product_content_id", "created_at", "updated_at") }
		end

		private

		def unique_product_sku_across_catalogues_and_groups
			# if new_record? || product_sku_changed?
				if BxBlockCatalogue::ProductVariantGroup.where.not(id: id).exists?(product_sku: product_sku) ||
					BxBlockCatalogue::Catalogue.exists?(sku: product_sku)
					errors.add(:product_sku, "must be unique across catalogues and product variant groups")
				end
			# end
		end

		def create_besku
			self.product_besku = generate_unique_besku(:besku) unless product_besku.present?
			self.product_bibc = generate_unique_besku(:bibc) unless product_bibc.present?
		end

	    def generate_unique_besku(field)
	      gen_besku = nil
	      loop do
	        gen_besku = SecureRandom.hex(8).upcase
	        break unless Catalogue.exists?(field => gen_besku) && ProductVariantGroup.exists?("product_#{field}".to_sym => gen_besku)
	      end
	      gen_besku
	    end

	end
end
