module BxBlockSurveys
  class InternUserGenericQuestion < BuilderBase::ApplicationRecord
    self.table_name = :intern_user_generic_questions
    belongs_to :business_user, class_name: 'AccountBlock::BusinessUser'
    belongs_to :internship, class_name: "BxBlockNavmenu::Internship"
    has_many :intern_user_generic_answers, class_name: "BxBlockSurveys::InternUserGenericAnswer", dependent: :destroy
    validates :question , presence: true,length: { maximum: 100, message: "must be 100 characters or fewer" }
    validate :question_limit_per_user, on: :create

    private

    def question_limit_per_user
      count = internship&.intern_user_generic_questions.present? ? internship.intern_user_generic_questions.count: 0
      if count >= 3
        errors.add(:base, 'You can only create up to 3 Generic Question for one internship.')
      end
    end
  end 
end