module BxBlockContactUs
    class AdminReply < ApplicationRecord
		self.table_name = :admin_replies
        belongs_to :contact, class_name: 'BxBlockContactUs::Contact'
        has_one_attached :image
        validates :description, presence: true
    end
end
