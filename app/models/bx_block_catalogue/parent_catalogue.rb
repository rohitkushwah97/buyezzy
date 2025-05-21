module BxBlockCatalogue
  class ParentCatalogue < BxBlockCatalogue::ApplicationRecord
    self.table_name = :parent_catalogues

    belongs_to :category,
    class_name: "BxBlockCategories::Category",
    foreign_key: "category_id"
    belongs_to :brand, class_name: "BxBlockCatalogue::Brand", foreign_key: "brand_id"
    belongs_to :sub_category, class_name: "BxBlockCategories::SubCategory", optional: true
    belongs_to :mini_category, class_name: "BxBlockCategories::MiniCategory", optional: true
    belongs_to :micro_category, class_name: "BxBlockCategories::MicroCategory", optional: true
    has_many :catalogues, class_name: "BxBlockCatalogue::Catalogue", dependent: :nullify

    validates :besku, uniqueness: true
    has_one_attached :product_image, dependent: :destroy
    validates :product_title, length: { in: 5..35 }
    # validates :prod_model_no, format: { with: /\A[A-Z0-9]+\z/, message: "should be uppercase alphanumeric" }, length: { in: 5..13, allow_blank: true }
    validate :custom_prod_model_no_validation

    before_create :generate_unique_besku
    validate :validate_image_type

    # has_one :barcode, class_name: "BxBlockCatalogue::Barcode", dependent: :destroy
    # has_one :catalogue_offer, class_name: "BxBlockCatalogue::CatalogueOffer", dependent: :destroy
    # has_many :deal_catalogues, class_name: "BxBlockCatalogue::DealCatalogue", dependent: :destroy
    # has_many :deals, through: :deal_catalogues, class_name: "BxBlockCatalogue::Deal"

    
    # has_one :product_content, class_name: "BxBlockCatalogue::ProductContent", dependent: :destroy

    
    # has_many :review_and_ratings, class_name: "BxBlockCatalogue::Review", dependent: :destroy
    # has_many :catalogue_variants, class_name: "BxBlockCatalogue::CatalogueVariant", dependent: :destroy
    # has_many :product_variant_groups, class_name: "BxBlockCatalogue::ProductVariantGroup", dependent: :destroy
    # has_many :favourites, as: :favouriteable, class_name: "BxBlockFavourites::Favourite", dependent: :destroy
    # has_many :order_items, class_name: 'BxBlockShoppingCart::OrderItem', dependent: :destroy
    # has_many :orders, through: :order_items, class_name: 'BxBlockShoppingCart::Order'


    # has_many :subscribe_coupons, class_name: "BxBlockCouponCg::SubscribeCoupon", dependent: :destroy
    # has_many :coupon_codes, through: :subscribe_coupons, class_name: "BxBlockCouponCg::CouponCode", source: :coupon
    # belongs_to :seller, class_name: "AccountBlock::Account", optional: true

    # validates :sku, presence: true, uniqueness: true
    # has_many :catalogue_contents, class_name: "BxBlockCatalogue::CatalogueContent", dependent: :destroy
    # accepts_nested_attributes_for :catalogue_contents

    # has_many :custom_fields, through: :catalogue_contents, class_name: "BxBlockCategories::CustomField"

    
    # has_and_belongs_to_many :store_menus, join_table: 'catalogues_store_menus', class_name: "BxBlockStoreManagement::StoreMenu", optional: true

    # accepts_nested_attributes_for :catalogue_variants, allow_destroy: true

    def generate_unique_besku
        self.besku = SecureRandom.hex(8).upcase
    end

    private

    def validate_image_type
        allowed_types = %w(image/jpeg image/jpg image/png image/webp)

         if product_image.attached? && !product_image.content_type.in?(allowed_types)
            errors.add(:product_image, 'must be a JPEG/JPG/PNG/WebP file')
        end
    end

    def custom_prod_model_no_validation
        if prod_model_no.present?
          unless prod_model_no.match?(/\A[A-Z0-9]+\z/)
            errors.add(:prod_model_no, "should be uppercase alphanumeric")
          end

          unless (5..13).cover?(prod_model_no.length)
                errors.add(:prod_model_no, "length should be between 5 and 13 characters")
          end
        end
    end

  end
end
