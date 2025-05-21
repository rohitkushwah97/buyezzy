class ChangeRatingToDecimalInReviewAndRatings < ActiveRecord::Migration[6.0]
  def change
  	change_column :review_and_ratings, :rating, :decimal, precision: 3, scale: 1
  end
end
