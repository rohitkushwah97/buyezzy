module BxBlockProfile
  class CareerInterest < BxBlockProfile::ApplicationRecord
    self.table_name = :career_interests

    belongs_to :intern_user, class_name: "AccountBlock::InternUser", foreign_key: "intern_user_id"
    belongs_to :industry, class_name: "BxBlockCategories::Industry", foreign_key: "industry_id"
    belongs_to :role, class_name: "BxBlockCategories::Role", foreign_key: "role_id"
    has_one :user_survey,class_name: "BxBlockSurveys::UserSurvey", dependent: :destroy

    validates :intern_user, presence: true, uniqueness: { scope: [:role_id, :industry_id], message: "has already been taken industry_role combination." }
    after_create :user_career_count, :create_user_survey

    private

    def user_career_count
      self.intern_user.update_column(:career_count, self.intern_user.career_count+1)
    end

    def create_user_survey
      self.build_user_survey(account_id:self.intern_user_id,role_id: self.role_id,quiz_status: "pending").save!
    end
  end
end
