# frozen_string_literal: true

module BxBlockProfile
  class Profile < BxBlockProfile::ApplicationRecord
    include ActiveStorageSupport::SupportForBase64
    ActiveSupport.run_load_hooks(:profile, self)
    self.table_name = :profiles
    has_one_base64_attached :photo
    belongs_to :account, class_name: 'AccountBlock::Account'
    has_one :current_status, class_name: 'BxBlockEducationalUserProfile::CurrentStatus'
    accepts_nested_attributes_for :current_status, allow_destroy: true
    has_many :publication_patent, class_name: 'BxBlockEducationalUserProfile::PublicationPatent'
    accepts_nested_attributes_for :publication_patent, allow_destroy: true
    has_many :awards, class_name: 'BxBlockEducationalUserProfile::Award'
    accepts_nested_attributes_for :awards, allow_destroy: true
    has_many :hobbies, class_name: 'BxBlockEducationalUserProfile::Hobby'
    accepts_nested_attributes_for :hobbies, allow_destroy: true
    has_many :courses, class_name: 'BxBlockEducationalUserProfile::Course'
    accepts_nested_attributes_for :courses, allow_destroy: true
    has_many :test_score_and_courses, class_name: 'BxBlockEducationalUserProfile::TestScoreAndCourse'
    accepts_nested_attributes_for :test_score_and_courses, allow_destroy: true
    has_many :career_experiences, class_name: 'BxBlockEducationalUserProfile::CareerExperience'
    accepts_nested_attributes_for :career_experiences, allow_destroy: true
    has_one :video, class_name: 'BxBlockVideolibrary::Video'
    has_many :educational_qualifications, class_name: 'BxBlockEducationalUserProfile::EducationalQualification'
    accepts_nested_attributes_for :educational_qualifications, allow_destroy: true
    has_many :projects, class_name: 'BxBlockEducationalUserProfile::Project'
    accepts_nested_attributes_for :projects, allow_destroy: true
    has_many :languages, class_name: 'BxBlockEducationalUserProfile::Language'
    has_many :contacts, class_name: 'BxBlockContactsintegration::Contact'
    has_many :interview_schedules, class_name: 'BxBlockCalendar::InterviewSchedule'
    validates :country, presence: true
  end
end
