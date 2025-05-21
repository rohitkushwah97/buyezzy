module BxBlockDashboard
	class BannerGroup < ApplicationRecord
		self.table_name = :banner_groups

		validates :group_name, presence: true, uniqueness: true
		has_many :banners, class_name: 'BxBlockDashboard::Banner', dependent: :destroy
	end
end