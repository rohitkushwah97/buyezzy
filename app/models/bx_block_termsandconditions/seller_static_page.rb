module BxBlockTermsandconditions
	class SellerStaticPage < ApplicationRecord
		self.table_name = :seller_static_pages

		validates :content, presence: true
		validates :title, presence: true, uniqueness: true

		scope :header_pages, -> { where(section: 'header') }
		scope :footer_pages, -> { where(section: 'footer') }

	end
end