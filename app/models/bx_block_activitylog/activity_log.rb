module BxBlockActivitylog
	class ActivityLog < ApplicationRecord
		self.table_name = :activity_logs
		belongs_to :user, class_name: "AccountBlock::Account", optional: true

		before_save :assign_user_type
		scope :by_user_type, ->(user_type) { where(user_type: user_type) }

		private

		def assign_user_type
			if user
				self.user_type = user.user_type
				self.user_email = user.email
				self.accessed_at = Time.current
			end
		end
	end
end