# frozen_string_literal: true

module BxBlockCategories
  class Role < BxBlockCategories::ApplicationRecord
    self.table_name = :roles
    validates :name, presence: true
    validates_uniqueness_of :name, scope: :industry_id
    belongs_to :industry
    has_one :survey, class_name: "BxBlockSurveys::Survey", dependent: :destroy
    has_many :internships, class_name: "BxBlockNavmenu::Internship",foreign_key: 'role_id', dependent: :destroy
    has_many :career_interests, class_name: "BxBlockProfile::CareerInterest", dependent: :destroy
    
    after_create :create_survey
    before_update :update_survey

    def create_survey
      survey_name = "#{name} - #{industry.name} Quiz"
      survey = BxBlockSurveys::Survey.new(name: survey_name, role_id: id)
      survey.skip_minimum_questions_validation = true

      if survey.save
        puts "Survey created successfully: #{survey.inspect}"
      else
        puts "Error creating survey: #{survey.errors.full_messages.join(', ')}"
      end
    end

    def update_survey
      survey_name = "#{name} - #{industry.name} Quiz"
      # Skip the minimum questions validation
      survey.skip_minimum_questions_validation = true
      
      if survey.update(name: survey_name, role_id: id)
        puts "Survey updated successfully: #{survey.inspect}"
      else
        puts "Error updating survey: #{survey.errors.full_messages.join(', ')}"
      end
    end
  end
end
