# frozen_string_literal: true

module BxBlockProfile
  class UniversityEducation < BxBlockProfile::ApplicationRecord
    self.table_name = :university_educations
    belongs_to :intern_user, class_name: "AccountBlock::InternUser"
    belongs_to :educational_status
    belongs_to :university
    after_save :remove_other_education

    private

    def remove_other_education
      intern_user.school_education&.destroy
      intern_user.update(career_count:0)
    end
  end
end