# frozen_string_literal: true

module BxBlockProfile
  class SchoolEducation < BxBlockProfile::ApplicationRecord
    self.table_name = :school_educations
    belongs_to :intern_user, class_name: "AccountBlock::InternUser"
    belongs_to :academic_level
    belongs_to :educational_status
    belongs_to :school
    after_save :remove_other_education

    private
    
    def remove_other_education
      intern_user.university_education&.destroy
      intern_user.career_interests&.destroy_all
      intern_user.update(career_count:0)
    end
  end
end