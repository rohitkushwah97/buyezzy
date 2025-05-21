module BxBlockCatalogue
	class WarehouseCatalogue < ApplicationRecord
		self.table_name = :warehouse_catalogues

		belongs_to :warehouse, class_name: "BxBlockCatalogue::Warehouse"
		belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue"
		belongs_to :product_variant_group, class_name: "BxBlockCatalogue::ProductVariantGroup", optional: true

		validate :unique_catalogue_and_variant_in_warehouse
		# validate :unique_catalogue_in_warehouse

		after_save :update_stocks_to_catalogue

		private

		def unique_catalogue_and_variant_in_warehouse
			existing_record = BxBlockCatalogue::WarehouseCatalogue.find_by(warehouse_id: warehouse_id, catalogue_id: catalogue_id, product_variant_group_id: product_variant_group_id)
			if existing_record && existing_record != self
				errors.add(:base, "This catalogue is already exist in this warehouse")
			end
		end

		def unique_catalogue_in_warehouse
			existing_record = BxBlockCatalogue::WarehouseCatalogue.where(catalogue_id: catalogue_id, product_variant_group_id: product_variant_group_id).where.not(warehouse_id: warehouse_id).first
			if existing_record
				errors.add(:base, "This catalogue is already assigned to another warehouse")
			end
		end

		def update_stocks_to_catalogue
			catalogue.stocks = self.stocks
			catalogue.save
		end

	end
end