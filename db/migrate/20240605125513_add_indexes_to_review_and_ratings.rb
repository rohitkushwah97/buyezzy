class AddIndexesToReviewAndRatings < ActiveRecord::Migration[6.0]
  def change
  	add_index :review_and_ratings, :catalogue_id
    add_index :review_and_ratings, :review_type
    add_index :review_and_ratings, :rating
    add_index :review_and_ratings, :reviewer_id
    add_index :review_and_ratings, :account_id
    add_index :review_and_ratings, :is_approved
  end
end
