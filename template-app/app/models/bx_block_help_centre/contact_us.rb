module BxBlockHelpCentre
  class ContactUs < BxBlockHelpCentre::ApplicationRecord
    self.table_name = :contact_us

    belongs_to :issue_type

    validates :full_name, :email, :issue_type, :inquiry_details, presence: true
    validates :inquiry_details, length: { maximum: 500 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, format: { with: VALID_EMAIL_REGEX, message: 'must be a valid email address' }
  end
end