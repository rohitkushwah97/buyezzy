module BxBlockSettings
  class WorkSchedule < ApplicationRecord
    self.table_name = :work_schedules
    has_one_attached :icon
    validates_presence_of :schedule
    validates :schedule, uniqueness: { case_sensitive: false }
  end
end
