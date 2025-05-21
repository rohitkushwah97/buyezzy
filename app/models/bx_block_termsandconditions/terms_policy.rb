module BxBlockTermsandconditions
	class TermsPolicy < ApplicationRecord

		self.table_name = :terms_policies

		validates :content, presence: true
		validates :page_title, presence: true, uniqueness: true

	end
end