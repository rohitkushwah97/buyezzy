module BxBlockCatalogue
  class ProductVariantGroupJob < ApplicationJob
    queue_as :default

    retry_on StandardError, wait: 2.minutes, attempts: 5

    def perform(product_variant_group_id)
      product_variant_group = BxBlockCatalogue::ProductVariantGroup.find(product_variant_group_id)
      product_variant_group.create_and_associate_variant_product
      Rails.logger.info("Successfully created variant product for ProductVariantGroup ID: #{product_variant_group_id}")
    rescue StandardError => e
      Rails.logger.error("Error creating variant product for ProductVariantGroup ID #{product_variant_group_id}: #{e.message}")
      raise e
    end
  end
end