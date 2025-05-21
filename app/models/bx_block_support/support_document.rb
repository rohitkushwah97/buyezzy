module BxBlockSupport
	class SupportDocument < ApplicationRecord
		self.table_name = :support_documents

		validates :content, presence: true
		validates :page_title, presence: true, uniqueness: true
	end
end