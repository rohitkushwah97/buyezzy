class Threshold < ApplicationRecord
  validates :threshold_percentage, presence: true, inclusion: { in: 0..100 }
end
