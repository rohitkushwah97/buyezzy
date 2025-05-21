module BxBlockCatalogue
  class Review < BxBlockCatalogue::ApplicationRecord
    self.table_name = :review_and_ratings

    belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue"
    belongs_to :account, foreign_key: :reviewer_id, class_name: "AccountBlock::Account"
    # adding optional to not produce error after merge
    belongs_to :order_item, class_name: 'BxBlockShoppingCart::OrderItem', optional: true

    validates_presence_of :reviewer_id, :catalogue_id, :rating
    validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
    # validate :check_existing_approved_review, on: [:create, :update]
    has_many_attached :review_images, dependent: :destory
    validate :validate_review_images

    has_many :helpful_reviews, class_name: "BxBlockCatalogue::HelpfulReview", dependent: :destroy
    has_many :helpful_accounts, through: :helpful_reviews, class_name: "AccountBlock::Account", source: :account
    accepts_nested_attributes_for :helpful_reviews, allow_destroy: true

    #approved reviews
    scope :approved_reviews, -> { where(is_approved: true) }
    scope :seller_reviews, -> { where(review_type: 'seller') }

    def helpful_count
      helpful_reviews.count
    end

    def helpful_by?(customer)
      helpful_reviews.exists?(customer_id: customer.id)
    end

    private

    def validate_review_images
      return unless review_images.attached?

      review_images.each do |image|
        if !image.content_type.in?(%w[image/png image/jpg image/jpeg]) || image.blob.byte_size > 5.megabytes
          errors.add(:review, 'Failed to upload image. only png, jpg, jpeg format is allowed and maximum size is 5mb')
        end
      end
    end
  end
end
