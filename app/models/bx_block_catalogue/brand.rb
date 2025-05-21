module BxBlockCatalogue
	class Brand < BxBlockCatalogue::ApplicationRecord
		self.table_name = :brands
		belongs_to :account, class_name: "AccountBlock::Account", optional: true
		has_one_attached :branding_tradmark_certificate, dependent: :destroy
		validates :brand_name, presence: true, uniqueness: { case_sensitive: false }
		VALID_URL_REGEX = /\A((http|https):\/\/)?(www\.)?[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+(\S*)?\z/i
		validates :brand_website, presence: true, format:{ with: VALID_URL_REGEX, message: "is not valid url"}
		# validates :brand_name_arabic, presence: true
		has_one_attached :brand_image, dependent: :destroy

		YEARS = (1900..Date.current.year).to_a.freeze
		validates :brand_year, inclusion: { in: YEARS, allow_blank: true }

		has_many :catalogues, class_name: "BxBlockCatalogue::Catalogue"
		has_many :restricted_brands, class_name: "BxBlockCatalogue::RestrictedBrand", dependent: :destroy
		has_one :store, class_name: "BxBlockStoreManagement::Store", dependent: :destroy
		has_many :gated_brands, class_name: "BxBlockCatalogue::GatedBrand", dependent: :destroy
		has_one :top_brand, class_name: "BxBlockDashboard::TopBrand", dependent: :destroy
		has_many :parent_catalogues, class_name: "BxBlockCatalogue::ParentCatalogue"
		before_destroy :check_for_associations
		before_save :strip_whitespace
		after_update :send_email_for_brand_approval, if: :approved_now?
		private

		def strip_whitespace
			self.brand_name = brand_name.strip if brand_name.present?
		end

		def check_for_associations
			if catalogues.exists? || store.present?
				errors.add(:base, "Cannot delete brand because it is associated with products or store.")
			end
		end

		def approved_now?
			saved_change_to_approve? && approve
		end

		def send_email_for_brand_approval
			@account = self.account
			BxBlockCatalogue::BrandApprovalMailer
			.with(account: @account)
			.brand_approval_email.deliver_now
		end
	end
end
