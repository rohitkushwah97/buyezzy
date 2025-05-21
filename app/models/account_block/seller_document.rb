module AccountBlock
	class SellerDocument < AccountBlock::ApplicationRecord
		self.table_name = :seller_documents
		belongs_to :account, class_name: "AccountBlock::Account"

		DOCUMENT_TYPES = {
			trading_license: 'Trading License or Commercial Registration',
			passport: 'Passport or Residence ID',
			residence_visa: 'Residence visa for non-nationals',
			vat_certificate: 'VAT Certificate or Reason for not having it',
			iban_certificate: 'IBAN Certificate or Bank Details'
		}.freeze

	  # Document type validations
	  validates :document_type, presence: true, inclusion: { in: DOCUMENT_TYPES.values }
	  
	  # Document name and file upload associations
	  has_many_attached :document_files, dependent: :destroy

	  validate :only_one_status_selected

	  # Additional fields for specific document types
	  validate :validate_documents
	  validates :vat_reason, presence: true, if: :vat_certificate_with_reason?
	  validates :account_no, :iban, :bank_address, :name, :bank_name, :swift_code, presence: true, if: :iban_certificate_without_file?
	  before_update :remove_vat_reason, if: :vat_document_present?
	  before_update :remove_iban_attributes, if: :iban_document_present?

	  after_update :account_verification_notification

	  private

	  def only_one_status_selected
	  	if approved? && rejected?
	  		errors.add(:base, "Only one status can be selected: either 'approved' or 'rejected', but not both.")
	  	end
	  end

	  def validate_documents
	  	unless [DOCUMENT_TYPES[:residence_visa], DOCUMENT_TYPES[:vat_certificate], DOCUMENT_TYPES[:iban_certificate]].include?(document_type) || document_files.present?
	  		errors.add(:document_files, "must be attached")
	  	end
	  end


	  def vat_certificate_with_reason?
	  	document_type == DOCUMENT_TYPES[:vat_certificate] && document_files.blank?
	  end

	  def iban_certificate_without_file?
	  	document_type == DOCUMENT_TYPES[:iban_certificate] && !document_files.attached?
	  end

	  def vat_document_present?
	  	document_type == DOCUMENT_TYPES[:vat_certificate] && document_files.present?
	  end

	  def iban_document_present?
	  	document_type == DOCUMENT_TYPES[:iban_certificate] && document_files.present?
	  end

	  def remove_vat_reason
	  	self.vat_reason = nil
	  end

	  def remove_iban_attributes
	  	self.account_no = nil
	  	self.iban = nil
	  	self.bank_address = nil
	  	self.name = nil
	  	self.bank_name = nil
	  	self.swift_code = nil
	  end

	  def account_verification_notification
	  	if all_documents_verified?
	  		BxBlockEmailNotifications::SendEmailNotificationService
	  		.with(account: account, subject: 'Account Verification Successful', file: 'account_verification_success')
	  		.notification.deliver_now
	  	elsif rejected_status_changed?
	  		BxBlockEmailNotifications::SendEmailNotificationService
	  		.with(account: account, subject: 'Account Verification Failed', file: 'document_or_account_verification_failure')
	  		.notification.deliver_now
	  	else
	  		puts " "
	  	end
	  end

	  def all_documents_verified?
	  	account.seller_documents.where(approved: true).count == DOCUMENT_TYPES.size
	  end

	  def any_document_rejected?
	  	account.seller_documents.where(rejected: true).exists?
	  end

	  def rejected_status_changed?
	  	saved_change_to_rejected? && rejected?
	  end

	end
end