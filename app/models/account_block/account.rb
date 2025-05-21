module AccountBlock
  class Account < AccountBlock::ApplicationRecord
    ActiveSupport.run_load_hooks(:account, self)
    self.table_name = :accounts

    include Wisper::Publisher

    has_secure_password
    before_validation :parse_full_phone_number
    before_create :generate_api_key
    has_one :blacklist_user, class_name: "AccountBlock::BlackListUser", dependent: :destroy
    after_save :set_black_listed_user
    before_save :set_full_name

    enum status: %i[regular suspended deleted]

    scope :active, -> { where(activated: true) }
    scope :existing_accounts, -> { where(status: ["regular", "suspended"]) }
    scope :buyer_accounts, -> { where(user_type: 'buyer') }
    scope :seller_accounts, -> { where(user_type: 'seller') }

    validates :email, :full_phone_number, presence: true
    validate :email_uniqueness_within_user_type
    validate :phone_number_uniqueness_within_user_type

    validate :valid_phone_number
    has_many :seller_documents, class_name: "AccountBlock::SellerDocument", dependent: :destroy
    has_many :suggestion_feedbacks, class_name: "AccountBlock::SuggestionFeedback", dependent: :destroy
    has_many :user_delivery_addresses, class_name: "AccountBlock::UserDeliveryAddress", dependent: :destroy
    has_many :brands, class_name: "BxBlockCatalogue::Brand", dependent: :destroy
    has_many :favourites, class_name: "BxBlockFavourites::Favourite", foreign_key: "user_id", dependent: :destroy
    has_many :orders, class_name: 'BxBlockShoppingCart::Order', foreign_key: :customer_id, dependent: :destroy
    has_many :return_exchange_requests, class_name: 'BxBlockShoppingCart::ReturnExchangeRequest', foreign_key: :customer_id, dependent: :destroy
    has_many :stores, class_name: "BxBlockStoreManagement::Store", dependent: :destroy
    has_many :subscribe_coupons, class_name: "BxBlockCouponCg::SubscribeCoupon", dependent: :destroy
    has_many :coupon_codes, through: :subscribe_coupons, class_name: "BxBlockCouponCg::CouponCode", source: :coupon
    has_many :catalogues, class_name: "BxBlockCatalogue::Catalogue", foreign_key: :seller_id, dependent: :destroy
    has_many :deal_catalogues, class_name: "BxBlockCatalogue::DealCatalogue", foreign_key: :seller_id, dependent: :destroy
    has_many :warehouses, class_name: "BxBlockCatalogue::Warehouse", dependent: :destroy
    has_many :review_and_ratings, class_name: "BxBlockCatalogue::Review", dependent: :destroy
    has_many :addresses, class_name:"BxBlockAddress::Address", foreign_key: :seller_id, dependent: :destroy
    has_many :catalogue_variants, class_name: "BxBlockCatalogue::CatalogueVariant", foreign_key: :seller_id, dependent: :destroy
    has_many :restricted_brands, class_name: "BxBlockCatalogue::RestrictedBrand", foreign_key: :seller_id, dependent: :destroy
    has_many :delivery_requests, class_name: 'BxBlockOrderManagement::DeliveryRequest', dependent: :destroy, foreign_key: 'seller_id'
    has_many :activity_logs, class_name: "BxBlockActivitylog::ActivityLog", foreign_key: :user_id, dependent: :nullify
    has_many :wms_product_infos, class_name: "BxBlockOrderManagement::WmsProductInfo", foreign_key: :seller_id, dependent: :destroy
    has_many :wms_consignment_orders, class_name: "BxBlockOrderManagement::WmsConsignmentOrder", foreign_key: :seller_id, dependent: :destroy
    has_many :invoice_billings, class_name: 'BxBlockInvoicebilling::InvoiceBilling', foreign_key: :customer_id, dependent: :destroy
    has_many :product_views, class_name: "BxBlockSalesreporting::ProductView", foreign_key: :user_id, dependent: :destroy
    
    accepts_nested_attributes_for :addresses
    has_one_attached :profile_picture

    before_save :set_default_language
    
    private

    def parse_full_phone_number
      phone = Phonelib.parse(full_phone_number)
      self.full_phone_number = phone.sanitized
      self.country_code = phone.country_code
      self.phone_number = phone.raw_national
    end

    def valid_phone_number
      unless Phonelib.valid?(full_phone_number)
        errors.add(:full_phone_number,"Invalid or Unrecognized")
      end
    end

    def generate_api_key
      loop do
        @token = SecureRandom.base64.tr("+/=", "Qrt")
        break @token unless Account.exists?(unique_auth_id: @token)
      end
      self.unique_auth_id = @token
    end

    def set_black_listed_user
      if is_blacklisted_previously_changed?
        if is_blacklisted
          AccountBlock::BlackListUser.create(account_id: id)
        else
          blacklist_user.destroy
        end
      end
    end

    def set_full_name
      self.full_name = "#{first_name} #{last_name}"
    end

    def email_uniqueness_within_user_type
      if Account.where(email: email, user_type: user_type).where.not(id: id).exists?
        errors.add(:email, "has already been taken")
      end
    end

    def phone_number_uniqueness_within_user_type
      if Account.where(full_phone_number: full_phone_number, user_type: user_type).where.not(id: id).exists?
        errors.add(:full_phone_number, "has already been taken")
      end
    end

    def set_default_language
      self.language = 'English' if self.language.blank?
    end
  end
end
