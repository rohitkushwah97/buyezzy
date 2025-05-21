module BxBlockStoreManagement
	class Store < ApplicationRecord
		self.table_name = :stores
		validates :store_year,:store_url,:website_social_url, presence: true
		validates :store_name, presence: true , uniqueness: true
		has_one_attached :brand_trade_certificate, dependent: :destroy
		has_many :store_menus, class_name: "BxBlockStoreManagement::StoreMenu", dependent: :destroy
		has_many :store_dashboard_sections, class_name: "BxBlockStoreManagement::StoreDashboardSection", dependent: :destroy
		belongs_to :account, class_name: "AccountBlock::Account", optional: true
		belongs_to :brand, class_name: "BxBlockCatalogue::Brand", optional: false
       	validates :brand_trade_certificate ,presence: true
		validate :one_brand_per_store

		private

		def one_brand_per_store
			if brand && BxBlockStoreManagement::Store.where(brand_id: brand_id).where.not(id: id).exists?
				errors.add(:brand, "can only be associated with one store")
			end
		end
	end
end