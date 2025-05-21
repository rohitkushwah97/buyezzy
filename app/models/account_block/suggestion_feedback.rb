module AccountBlock
	class SuggestionFeedback < AccountBlock::ApplicationRecord
		self.table_name = :suggestion_feedbacks
		belongs_to :account, class_name: "AccountBlock::Account", optional: true
		validates :email, :first_name,:last_name,:detail_type,:detail, presence: true
	end
end