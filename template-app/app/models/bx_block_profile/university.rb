# frozen_string_literal: true

module BxBlockProfile
  class University < BxBlockProfile::ApplicationRecord
    self.table_name = :universities

    before_validation :assign_educational_status
    validates_presence_of :name
    validates :name, uniqueness: { case_sensitive: false }
    belongs_to :educational_status

    private

    def assign_educational_status
      self.educational_status ||= EducationalStatus.find_by_code("UNI")
    end
  end
end