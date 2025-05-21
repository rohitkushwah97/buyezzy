module BxBlockSurveys
	class ContactIntern < BuilderBase::ApplicationRecord
		self.table_name = :contact_interns
		belongs_to :intern_user, class_name: 'AccountBlock::InternUser',foreign_key: 'intern_user_id'
		belongs_to :internship, class_name: 'BxBlockNavmenu::Internship',foreign_key: 'internship_id'
		enum decision: { decision: 0, offer_made: 1, rejected: 2 }
		validates :intern_user_id, uniqueness: { scope: :internship_id }
	end
end
