module BxBlockStoreManagement
	class StoreSectionGrid < ApplicationRecord
		self.table_name = :store_section_grids
		belongs_to :store_dashboard_section, class_name: "BxBlockStoreManagement::StoreDashboardSection"
		has_one :store, through: :store_dashboard_section, class_name: "BxBlockStoreManagement::Store"
		validates :grid_name, presence: true
    	validates :grid_no, presence: true, inclusion: { in: %w(grid_1 grid_2 grid_3 grid_4) }, uniqueness: { scope: :store_dashboard_section_id }
    	validates :grid_url, allow_blank: true, format: { with: /\A(?:https:\/\/|www\.)[^\s]+\z/, message: "should start with 'https://' or 'www.'" }
    	has_one_attached :grid_image, dependent: :destroy
		
	end
end