# frozen_string_literal: true

module BxBlockNavmenu
  class Internship < ApplicationRecord
    self.table_name = :bx_block_navmenu_internships
    before_validation :set_duration
    validates :start_date, :end_date, :deadline_date,:title, :description, :monthly_salary, presence: true
    validates :monthly_salary, numericality: { greater_than_or_equal_to: 0 }
    belongs_to :industry, class_name: 'BxBlockCategories::Industry', foreign_key: 'industry_id'
    belongs_to :role, class_name: 'BxBlockCategories::Role', foreign_key: 'role_id'
    belongs_to :work_location, class_name: 'BxBlockSettings::WorkLocation', foreign_key: 'work_location_id'
    belongs_to :work_schedule, class_name: 'BxBlockSettings::WorkSchedule', foreign_key: 'work_schedule_id'
    belongs_to :country, class_name: 'AccountBlock::Country', foreign_key: 'country_id'
    belongs_to :city, class_name: 'AccountBlock::City', foreign_key: 'city_id'
    belongs_to :business_user, class_name: 'AccountBlock::BusinessUser'
    has_many :make_offers, class_name: 'BxBlockSurveys::MakeOffer', foreign_key: 'internship_id', dependent: :destroy
    has_many :request_interviews,class_name: 'BxBlockRequestManagement::RequestInterview', dependent: :destroy
    has_many :intern_user_generic_questions, class_name: "BxBlockSurveys::InternUserGenericQuestion", dependent: :destroy
    has_many :intern_user_generic_answers, class_name: "BxBlockSurveys::InternUserGenericAnswer", dependent: :destroy
    has_many :business_user_generic_answers, class_name: "BxBlockSurveys::BusinessUserGenericAnswer", dependent: :destroy
    has_one :user_survey,class_name: "BxBlockSurveys::UserSurvey",foreign_key:'internship_id', dependent: :destroy
    has_and_belongs_to_many :accounts, class_name: "AccountBlock::Account", dependent: :destroy
    has_many :reports, class_name: "BxBlockProfile::Report", foreign_key: :internship_id, dependent: :destroy
    enum status: { draft: 0, active: 1, inactive: 2, 
      rejected: 5 }

    has_many :recommendations,class_name: 'BxBlockRecommendation::Recommendation',foreign_key: 'internship_id', dependent: :destroy
    has_many :recommended_users, through: :recommendations, source: :intern_user

    after_create :create_user_survey
    before_update :update_user_survey
    after_update :delete_recommendations, :create_recommendations

    has_many :contact_interns, class_name: 'BxBlockSurveys::ContactIntern',foreign_key: 'internship_id', dependent: :destroy
    has_many :contacted_intern_users, through: :contact_interns, source: :intern_user

    has_many :account_internships, class_name: 'BxBlockNavmenu::AccountInternship', dependent: :destroy
    has_many :applicants, through: :account_internships, source: :account

    scope :visible, -> { where('deadline_date >= ?', Date.today) }

    private

    def set_duration
      if end_date.present? && start_date.present?
        self.duration = (end_date - start_date).to_i
      end
    end

    def create_user_survey
      self.build_user_survey(account_id:self.business_user_id,role_id: self.role_id,quiz_status: "pending").save!
    end

    def update_user_survey
      if self.role_id_changed?
        user_survey = self.user_survey
        user_survey.destroy if user_survey.present?
        self.build_user_survey(account_id:self.business_user_id,role_id: self.role_id,quiz_status: "pending").save!
      end
    end

    def delete_recommendations
      self.recommendations.destroy_all if self.status == "inactive"
    end

    def create_recommendations
      BxBlockRecommendation::CreateApplicantRecommendationsJob.perform_later(self) if self.status == "active"
    end
  end
end