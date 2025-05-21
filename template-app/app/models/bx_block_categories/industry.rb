# frozen_string_literal: true

module BxBlockCategories
  class Industry < BxBlockCategories::ApplicationRecord
    self.table_name = :industries
    validates :name, presence: true
    validates_uniqueness_of :name
    has_many :roles, dependent: :destroy
    has_many :career_interests, class_name: "BxBlockProfile::CareerInterest", dependent: :destroy

    after_update :update_related_surveys

    private

    def update_related_surveys
      roles.find_each(&:update_survey)
    end

  end
end
