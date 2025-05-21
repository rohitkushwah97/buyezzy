module BxBlockSupport
	class Support < ApplicationRecord
		self.table_name = :supports
		validates :first_name, :last_name, :email, :details, presence: true
	end
end