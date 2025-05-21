module BxBlockStoreManagement
	class StoreMenu < ApplicationRecord
		self.table_name = :store_menus

		belongs_to :store, class_name: "BxBlockStoreManagement::Store", foreign_key: :store_id
		has_one_attached :cover_image, dependent: :destroy
		has_one_attached :logo, dependent: :destroy

		validate :header_validation
		validates :position, presence: true, uniqueness: { scope: :store_id }
		validates :title, presence: true, unless: -> { store_name.present? }
		has_and_belongs_to_many :catalogues, join_table: 'catalogues_store_menus', class_name: "BxBlockCatalogue::Catalogue", optional: true

		private

		def header_validation
			if store_name.present?
				if !cover_image.attached?
					errors.add(:cover_image, "must be attached when store name is present")
				end
				if !logo.attached?
					errors.add(:logo, "must be attached when store name is present")
				end
			end
		end
	end
end