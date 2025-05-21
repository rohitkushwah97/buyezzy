module BxBlockProfile
  class CompanyDetail < BxBlockProfile::ApplicationRecord
    self.table_name = :company_details
    has_one_attached :photo
    has_one_attached :photo_thumbnail
    belongs_to :industry, class_name: "BxBlockCategories::Industry"
    belongs_to :country, class_name: 'AccountBlock::Country'
    belongs_to :city, class_name: 'AccountBlock::City'
    belongs_to :business_user, class_name: 'AccountBlock::BusinessUser'
    validates :photo, content_type: { in: ['image/jpg', 'image/jpeg', 'image/svg', 'image/png', 'image/HEIC'], message: "Only jpeg, jpg, svg, png, and HEIC formats are supported." }

    validates :company_description , length: { maximum: 500, message: "must be 500 characters or fewer" }

    validates :company_name, :website_link,:address, presence: true,  unless: :skip_validation_admin?
      
    validate :parse_full_phone_number

    after_validation :change_update_by
    validate :photo_size_validation

    private

    def photo_size_validation
      if photo.attached? && photo.blob.byte_size > 5.megabytes
        errors.add(:photo, "Photo is too large. Maximum size allowed is 5 MB.")
      end
    end

    def skip_validation_admin?
      update_by == "admin"
    end

    def change_update_by
      self.update_by = ""
    end

    def parse_full_phone_number
      if contact_number.present? && !Phonelib.valid?(contact_number)
        errors.add(:contact_number, "Please enter a valid phone number.")
      else
        phone = Phonelib.parse(contact_number)
        self.contact_number = phone.sanitized
        self.country_code = phone.country_code
        self.phone_number = phone.raw_national
      end
    end
  end
end