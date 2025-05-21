module BxBlockCatalogue
  class HelpfulReview < BxBlockCatalogue::ApplicationRecord
  	self.table_name = :helpful_reviews

    belongs_to :review, class_name: "BxBlockCatalogue::Review"
    belongs_to :customer, class_name: "AccountBlock::Account"

    validates :review_id, uniqueness: { scope: :customer_id, message: 'You have already marked this review as helpful' }
  end
end