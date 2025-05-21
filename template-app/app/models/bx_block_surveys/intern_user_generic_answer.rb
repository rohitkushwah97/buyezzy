module BxBlockSurveys
  class InternUserGenericAnswer < BuilderBase::ApplicationRecord
    self.table_name = :intern_user_generic_answers
    belongs_to :account, class_name: 'AccountBlock::Account'
    belongs_to :internship, class_name: "BxBlockNavmenu::Internship"
    belongs_to :intern_user_generic_question, class_name: "BxBlockSurveys::InternUserGenericQuestion"
    validates :answer , length: { maximum: 500, message: "must be 500 characters or fewer" }
  end
end