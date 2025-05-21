module BxBlockSeoSetting
	class SeoSetting < BxBlockSeoSetting::ApplicationRecord
		self.table_name = :seo_settings
		validates :page_name, presence: true, uniqueness: true
	end
end
