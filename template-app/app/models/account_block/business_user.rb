module AccountBlock
  class BusinessUser < Account
    ActiveSupport.run_load_hooks(:business_user, self)
    include Wisper::Publisher

    has_one_attached :photo
    has_one_attached :photo_thumbnail

    has_many :business_user_generic_answers, class_name: 'BxBlockSurveys::BusinessUserGenericAnswer', dependent: :destroy

    has_many :business_user_generic_questions, through: :business_user_generic_answers, dependent: :destroy
    has_many :sent_offers, class_name: 'BxBlockSurveys::MakeOffer', foreign_key: 'business_user_id', dependent: :destroy


    has_one :company_detail, class_name: 'BxBlockProfile::CompanyDetail', dependent: :destroy
    has_many :intern_user_generic_questions, class_name: "BxBlockSurveys::InternUserGenericQuestion", dependent: :destroy
    has_many :user_surveys,class_name: "BxBlockSurveys::UserSurvey",foreign_key: 'account_id', dependent: :destroy
    has_many :internships, class_name: "BxBlockNavmenu::Internship", dependent: :destroy

    accepts_nested_attributes_for :company_detail, allow_destroy: true
    validate :valid_business_email
    after_create :create_profile
    
    INVALID_EMAIL_DOMAINS = %w[
      gmail.com
      yahoo.com
      outlook.com
      hotmail.com
      email.com
    ]

    private

    def create_profile
      self.build_company_detail.save(validate: false)
    end

    def valid_business_email
      return if email.blank?
       domain = email.split('@').last.downcase
      if INVALID_EMAIL_DOMAINS.include?(domain)
       return errors.add(:email, "You must use a business email")
      end
    end
  end
end
