class AddColumnRatingToReviewsReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews_reviews, :rating, :integer
    add_column :reviews_reviews, :prompt_manager_id, :integer
    add_column :reviews_reviews, :version_id, :integer
    add_column :reviews_reviews, :reviews_type, :string
    remove_column :reviews_reviews, :intern_id, :integer

  end
end
