module BxBlockReviews
  class Review < BxBlockReviews::ApplicationRecord
    self.table_name = :reviews_reviews

    belongs_to :account, class_name: "AccountBlock::Account"
    belongs_to :reviewer, foreign_key: :reviewer_id, class_name: "AccountBlock::Account"
    # validates :account_id,
      # uniqueness: {scope: [:reviewer_id, :anonymous], message: "already reviewed"},
      # if: :reviewer_id?

    # validates_presence_of :title, :description
    validates_presence_of :description

    enum reviews_type: { internship: "internship", chatbox: "chatbox", business_feedback: "business_feedback" }

    before_validation :set_review_type

    private

    def set_review_type
      if internship_id.present?
        self.reviews_type ||= "internship"
      elsif prompt_manager_id.present?
        self.reviews_type ||= "chatbox"
      else
        self.reviews_type ||= "business_feedback"
      end
    end
  end
end
