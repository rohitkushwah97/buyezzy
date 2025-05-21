module BxBlockSettings
  class WorkLocation < ApplicationRecord
    self.table_name = :work_locations
    has_one_attached :icon
    validates_presence_of :name
    validates :name, uniqueness: { case_sensitive: false }
  end
end
