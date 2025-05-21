module AccountBlock
  class InternUser < Account
    ActiveSupport.run_load_hooks(:intern_user, self)
    has_one :profile, class_name: "BxBlockProfile::Profile", foreign_key: 'account_id', dependent: :destroy
    has_one :university_education, class_name: "BxBlockProfile::UniversityEducation", dependent: :destroy
    has_one :school_education, class_name: "BxBlockProfile::SchoolEducation", dependent: :destroy
    has_many :career_interests, class_name: "BxBlockProfile::CareerInterest", dependent: :destroy
    validates_presence_of :date_of_birth
    validate :validate_age, :parse_full_phone_number
    has_many :received_offers, class_name: 'BxBlockSurveys::MakeOffer', foreign_key: 'intern_user_id', dependent: :destroy
    has_many :user_surveys,class_name: "BxBlockSurveys::UserSurvey",foreign_key: 'account_id', dependent: :destroy
    after_create :create_profile


    has_many :recommendations,class_name: 'BxBlockRecommendation::Recommendation', foreign_key: 'intern_user_id', dependent: :destroy
    has_many :recommended_internships, through: :recommendations, source: :internship

    has_many :contact_interns,class_name: 'BxBlockSurveys::ContactIntern',foreign_key: 'intern_user_id', dependent: :destroy
    has_many :contacted_internships, through: :contact_interns, source: :internship

    has_many :chatbot_interviews, class_name: 'BxBlockChatgpt3::ChatbotInterview', foreign_key: 'intern_user_id', dependent: :destroy


    accepts_nested_attributes_for :profile, allow_destroy: true
    accepts_nested_attributes_for :career_interests, allow_destroy: true

    scope :abc, -> { where(activated: true) }

    private

    def create_profile
      self.build_profile.save(validate:false)
    end

    def validate_age
      if date_of_birth.present? && date_of_birth > 16.years.ago
        errors.add(:date_of_birth, 'should be over 16 years old.')
      end
    end

    def parse_full_phone_number
      if full_phone_number.present? && !Phonelib.valid?(full_phone_number)
        errors.add(:full_phone_number, "Please enter a valid phone number.")
      else
        phone = Phonelib.parse(full_phone_number)
        self.full_phone_number = phone.sanitized
        self.country_code = phone.country_code
        self.phone_number = phone.raw_national
      end
    end
  end
end
