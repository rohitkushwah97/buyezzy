class AddColumnToReviewsReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews_reviews, :internship_id, :integer
    add_column :reviews_reviews, :intern_id, :integer
  end
end
