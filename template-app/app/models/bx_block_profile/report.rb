module BxBlockProfile
  class Report < BxBlockProfile::ApplicationRecord
    self.table_name = :reports

    belongs_to :created_by, class_name: "AccountBlock::Account", foreign_key: :created_by_id
    belongs_to :created_for, class_name: "AccountBlock::Account", foreign_key: :created_for_id, optional: true
    belongs_to :internship, class_name: "BxBlockNavmenu::Internship", foreign_key: :internship_id, optional: true

    VALID_TITLES = ['Inappropriate content', 'Misleading or false information', 'Discrimination or hate speech', 'Other'].freeze
    validates :title, presence: true, inclusion: { in: VALID_TITLES, message: "%{value} is not a valid report title" }
    validate :description_presence_for_other_title
    validate :only_one_field_present

    before_save :set_default_description

    private

    def only_one_field_present
      if internship_id.present? && created_for_id.present?
        errors.add(:base, "Only one of internship or account must be present.")
      end
    end

    def description_presence_for_other_title
      if title == 'Other' && description.blank?
        errors.add(:base, "Please provide description for 'Other' title.")
      end
    end

    def set_default_description
      unless title == 'Other'
        self.description = case title
        when 'Inappropriate content'
          "If you believe the information shared on this account is inappropriate, please report the account, and we will evaluate the case. Your report will help us maintain a safe and respectful environment for everyone."
        when 'Misleading or false information'
          "If you believe the information shared on this account is false or inaccurate, please report the account, and we will evaluate the case. Your report will help us maintain a safe and respectful environment for everyone."
        when 'Discrimination or hate speech'
          "If you believe the information shared on this account is discriminatory or contains hate speech, please report the account, and we will evaluate the case. Your report will help us maintain a safe and respectful environment for everyone."
        else
          self.description # Preserve current description, though this case should not be hit
        end
      end
    end
  end
end
