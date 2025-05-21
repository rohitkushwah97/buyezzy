# frozen_string_literal: true

module BxBlockProfile
  class School < BxBlockProfile::ApplicationRecord
    self.table_name = :schools

    belongs_to :educational_status

    validates :name, presence: true
    validates :name, uniqueness: { case_sensitive: false }
    before_validation :assign_educational_status

    private
    
    def assign_educational_status
      self.educational_status = EducationalStatus.find_by_code("SCH")
    end
  end
end