module BxBlockCatalogue
  class Catalogue < BxBlockCatalogue::ApplicationRecord
    self.table_name = :catalogues

    belongs_to :category,
               class_name: 'BxBlockCategories::Category',
               foreign_key: 'category_id'
    # // this clone product for variants(using self join)
    has_many :variant_products, class_name: 'BxBlockCatalogue::Catalogue', foreign_key: 'parent_product_id',
                                inverse_of: :parent_product, dependent: :destroy
    belongs_to :parent_product, class_name: 'BxBlockCatalogue::Catalogue', optional: true,
                                foreign_key: 'parent_product_id', inverse_of: :variant_products

    # // parent catalogue not using so making it optional instead of removing
    belongs_to :parent_catalogue, class_name: 'BxBlockCatalogue::ParentCatalogue', optional: true
    belongs_to :sub_category, class_name: 'BxBlockCategories::SubCategory', optional: true
    belongs_to :mini_category, class_name: 'BxBlockCategories::MiniCategory', optional: true
    belongs_to :micro_category, class_name: 'BxBlockCategories::MicroCategory', optional: true

    belongs_to :brand, class_name: 'BxBlockCatalogue::Brand', foreign_key: 'brand_id'
    has_many :warehouse_catalogues, class_name: 'BxBlockCatalogue::WarehouseCatalogue', dependent: :destroy
    has_many :warehouses, through: :warehouse_catalogues

    validates :sku, presence: true,
                    format: { with: %r{\A(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9!@#$%^&*()_+-={}\[\]:;"'<>,.?/\\|`~\s]*\z}, message: 'should be alphanumeric and special characters' }
    validates :sku, uniqueness: { scope: :parent_product_id }, if: -> { parent_product_id.nil? }
    validates :sku, presence: true, if: -> { is_variant? }
    validates :recommended_priority, allow_blank: true,
                                     inclusion: { in: 0..9, message: 'must be between 0(low) and 9(high)' }
    # validates :besku, presence: true
    has_one :barcode, class_name: 'BxBlockCatalogue::Barcode', dependent: :destroy
    has_one :catalogue_offer, class_name: 'BxBlockCatalogue::CatalogueOffer', dependent: :destroy
    has_many :deal_catalogues, class_name: 'BxBlockCatalogue::DealCatalogue', dependent: :destroy
    has_many :deals, through: :deal_catalogues, class_name: 'BxBlockCatalogue::Deal'

    has_many :catalogue_contents, class_name: 'BxBlockCatalogue::CatalogueContent', dependent: :destroy

    has_many :custom_fields, through: :catalogue_contents, class_name: 'BxBlockCategories::CustomField'

    has_one :product_content, class_name: 'BxBlockCatalogue::ProductContent', dependent: :destroy
    accepts_nested_attributes_for :catalogue_contents, :product_content, allow_destroy: true

    has_and_belongs_to_many :store_menus, join_table: 'catalogues_store_menus',
                                          class_name: 'BxBlockStoreManagement::StoreMenu', optional: true

    has_many :review_and_ratings, class_name: 'BxBlockCatalogue::Review', dependent: :destroy
    #   // this object is for variant product's variant attributes and values
    has_one :product_variant_group, class_name: 'BxBlockCatalogue::ProductVariantGroup',
                                    foreign_key: 'variant_product_id', dependent: :destroy
    #   //  this model is for variant attributes and values
    has_many :product_variant_groups, class_name: 'BxBlockCatalogue::ProductVariantGroup', dependent: :destroy
    #   //  this model is for group of attributes and values for variants
    has_many :catalogue_variants, through: :product_variant_groups, class_name: 'BxBlockCatalogue::CatalogueVariant'
    has_many :favourites, as: :favouriteable, class_name: 'BxBlockFavourites::Favourite', dependent: :destroy
    has_many :order_items, class_name: 'BxBlockShoppingCart::OrderItem', dependent: :destroy
    has_many :orders, through: :order_items, class_name: 'BxBlockShoppingCart::Order'

    has_one_attached :product_image, dependent: :destroy
    # validates :product_image, presence: true
    validate :validate_image_type

    has_many :subscribe_coupons, class_name: 'BxBlockCouponCg::SubscribeCoupon', dependent: :destroy
    has_many :coupon_codes, through: :subscribe_coupons, class_name: 'BxBlockCouponCg::CouponCode', source: :coupon
    belongs_to :seller, class_name: 'AccountBlock::Account', optional: true
    has_many :trending_product_selections, class_name: 'BxBlockDashboard::TrendingProductSelection', dependent: :destroy
    has_many :favorite_book_catalogues, class_name: 'BxBlockDashboard::AuthorFavoriteBookCatalogue', dependent: :destroy
    has_many :banners, class_name: 'BxBlockDashboard::Banner', dependent: :destroy

    has_many :wms_product_infos, class_name: 'BxBlockOrderManagement::WmsProductInfo', dependent: :destroy
    has_many :wms_consignment_orders, class_name: 'BxBlockOrderManagement::WmsConsignmentOrder', dependent: :destroy
    has_many :product_views, class_name: 'BxBlockSalesreporting::ProductView', dependent: :destroy

    before_save :assign_besku_if_not_exist

    before_save :validate_product_title
    before_save :set_default_content_status, if: :new_record?
    before_save :set_default_fulfillment, if: :new_record?
    before_save :archived_status_change
    before_save :update_final_price, if: -> { persisted? }

    after_save :create_catalogue_contents
    after_save :product_status_change_notification

    scope :low_to_high, -> { order(final_price: :asc) }
    scope :high_to_low, -> { order(final_price: :desc) }
    scope :product_title_AZ, -> { joins(:product_content).order('product_contents.product_title ASC') }
    scope :product_title_ZA, -> { joins(:product_content).order('product_contents.product_title DESC') }
    scope :whats_new, -> { order(created_at: :desc) }
    scope :recommended, -> { order(recommended_priority: :desc) }
    scope :popularity, -> { order(purchased_count: :desc) }

    def update_total_stocks
      total_stocks = warehouse_catalogues.sum(:stocks)
      update!(stocks: total_stocks)
    end

    def is_variant?
      is_variant
    end

    def update_final_price
      self.final_price = calculate_effective_price
      self.offer_percentage = calculate_offer_percentage
      self.stroked_price = calculate_stroked_price
    end

    def calculate_effective_price
      retail_price = product_content&.retail_price&.to_f || 0.0
      return catalogue_offer.sale_price.to_f if catalogue_offer&.active? && catalogue_offer.sale_price.present?
      active_deal = deal_catalogues.where(status: 'approved').last
      deal = fetch_active_deal(active_deal)
      if active_deal.present? && deal&.active?
        return active_deal.deal_price.to_f if active_deal.deal.discount_type == 'flat'
        discount = (retail_price * active_deal.deal.discount_value / 100.0).round(2)
        discount = [discount, active_deal.deal_price].min
        return (retail_price - discount).round(2)
      end
      retail_price || 0.0
    end

    def fetch_active_deal(active_deal)
      active_deal.deal if active_deal.present?
    end

    def calculate_stroked_price
      mrp = product_content&.mrp&.to_f
      retail_price = product_content&.retail_price&.to_f || 0.0

      active_deal = deal_catalogues.where(status: 'approved').last
      deal = fetch_active_deal(active_deal)

      return retail_price if catalogue_offer&.active? || active_deal.present? || deal&.active?

      return retail_price

      mrp || 0.0
    end

    def calculate_offer_percentage
      if catalogue_offer&.active? || deal_catalogues.where(status: 'approved').exists?
        retail_price = product_content&.retail_price&.to_f || 0.0
        return 0.0 if retail_price.zero? || final_price.blank?

        return ((retail_price - final_price) / retail_price * 100).round(2)
      end

      0.0
    end

    private

    def archived_status_change
      self.status = false if content_status == 'archived'
    end

    def validate_product_title
      return if product_content.blank? || product_content.product_title.blank?

      self.product_title = product_content.product_title
    end

    def validate_image_type
      allowed_types = %w[image/jpeg image/jpg image/png image/webp]

      return unless product_image.attached? && !product_image.content_type.in?(allowed_types)

      errors.add(:product_image, 'must be a JPEG/JPG/PNG/WebP file')
    end

    def assign_besku_if_not_exist
      self.besku = generate_unique_besku(:besku) if besku.blank?
      self.bibc = generate_unique_besku(:bibc) if bibc.blank?
    end

    def generate_unique_besku(field)
      gen_besku = nil
      loop do
        gen_besku = SecureRandom.hex(8).upcase
        unless Catalogue.exists?(field => gen_besku) && ProductVariantGroup.exists?("product_#{field}".to_sym => gen_besku)
          break
        end
      end
      gen_besku
    end

    def set_default_content_status
      self.content_status ||= 'under_review'
    end

    def set_default_fulfillment
      self.fulfilled_type ||= 'partner'
    end

    def create_catalogue_contents
      custom_fields = []

      custom_fields += category.custom_fields if category
      custom_fields += sub_category.custom_fields if sub_category.present?
      custom_fields += mini_category.custom_fields if mini_category.present?
      custom_fields += micro_category.custom_fields if micro_category.present?

      catalogue_contents.where.not(custom_field_id: custom_fields.map(&:id)).destroy_all
      return unless custom_fields.present?

      custom_fields.each do |custom_field|
        content = catalogue_contents.find_or_create_by(custom_field_id: custom_field.id)
        if content.custom_field_name != custom_field.field_name
          content.update(custom_field_name: custom_field.field_name)
        end
      end
    end

    def product_status_change_notification
      if (saved_change_to_content_status? || saved_change_to_status?) && content_status == 'accepted' && status == true
        BxBlockEmailNotifications::SendEmailNotificationService
          .with(product: self, account: seller, subject: 'Product Successfully Added', file: 'product_added_notification')
          .notification.deliver_now
      elsif saved_change_to_content_status? && content_status == 'rejected'
        BxBlockEmailNotifications::SendEmailNotificationService
          .with(product: self, account: seller, subject: 'Product Listing Failed', file: 'product_failure_notification')
          .notification.deliver_now
      end
    end
  end
end
