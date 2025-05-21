module BxBlockSupport
	class StaticPage < ApplicationRecord
		self.table_name = :static_pages
		validates :title, presence:true, uniqueness: true
		validates :content, presence: true
	end
end