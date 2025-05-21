module BxBlockSurveys
  class BusinessUserGenericAnswer < BuilderBase::ApplicationRecord
    self.table_name = :business_user_generic_answers
    belongs_to :business_user, class_name: 'AccountBlock::BusinessUser'
    belongs_to :internship, class_name: "BxBlockNavmenu::Internship"
    belongs_to :business_user_generic_question, class_name: "BxBlockSurveys::BusinessUserGenericQuestion"
    validates :answer , length: { maximum: 100, message: "must be 100 characters or fewer" }
  end
end