module BxBlockSurveys
  class BusinessUserGenericQuestion < BuilderBase::ApplicationRecord
    self.table_name = :business_user_generic_questions
    has_many :business_user_generic_answers, class_name: "BxBlockSurveys::BusinessUserGenericAnswer", dependent: :destroy
  end
end
