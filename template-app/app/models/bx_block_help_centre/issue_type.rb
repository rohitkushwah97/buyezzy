module BxBlockHelpCentre
  class IssueType < BxBlockHelpCentre::ApplicationRecord
    self.table_name = :issue_types

    has_many :contact_us_inquiries, class_name: 'BxBlockHelpCentre::ContactUs', dependent: :destroy
    validates :name, presence: true
  end
end