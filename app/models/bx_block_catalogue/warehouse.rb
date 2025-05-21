module BxBlockCatalogue
	class Warehouse < BxBlockCatalogue::ApplicationRecord
		self.table_name = :warehouses
		validates :warehouse_name, presence: true
		has_many :warehouse_catalogues, class_name: "BxBlockCatalogue::WarehouseCatalogue", dependent: :destroy
		has_many :catalogues, through: :warehouse_catalogues
		has_many :product_variant_groups, through: :warehouse_catalogues
		belongs_to :account, class_name: "AccountBlock::Account", optional: true
		has_many :delivery_request, class_name: 'BxBlockOrderManagement::DeliveryRequest', dependent: :destroy
	end
end
