# This migration comes from bx_block_reviews (originally 20210623090841)
# Protected File
class AddAnyonymousToBxBlockReviewsReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews_reviews, :anonymous, :boolean, default: false
  end
end
