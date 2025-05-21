# frozen_string_literal: true

module BxBlockProfile
  class EducationalStatus < BxBlockProfile::ApplicationRecord
    self.table_name = :educational_statuses

    has_many :schools, dependent: :destroy
    has_many :universities, dependent: :destroy

    validates_presence_of :name
    validates_uniqueness_of :name
  end
end