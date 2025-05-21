module BxBlockStoreManagement
	class StoreDashboardSection < ApplicationRecord
		self.table_name = :store_dashboard_sections
		validates :section_name, presence: true, inclusion: { in: %w(section_1 section_2 section_3 banner) }
    	validates :section_type, presence: true, inclusion: { in: %w(1_grid_layout 2_grids_layout 3_grids_layout 4_grids_layout) }, unless: -> { section_name == 'banner' }
    	has_one_attached :banner_image, dependent: :destroy
    	validates :banner_name, presence: true, if: -> { section_name == 'banner' }
    	validates :banner_url, allow_blank: true, format: { with: /\A(?:https:\/\/|www\.)[^\s]+\z/, message: "should start with 'https://' or 'www.'" }, if: -> { section_name == 'banner' }
		belongs_to :store, class_name: "BxBlockStoreManagement::Store", foreign_key: :store_id
		has_many :store_section_grids, class_name: "BxBlockStoreManagement::StoreSectionGrid", dependent: :destroy
		accepts_nested_attributes_for :store_section_grids, allow_destroy: true

		
	end
end