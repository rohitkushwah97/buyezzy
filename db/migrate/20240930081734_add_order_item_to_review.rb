class AddOrderItemToReview < ActiveRecord::Migration[6.0]
  def change
    add_column :review_and_ratings, :order_item_id, :bigint
    add_index :review_and_ratings, :order_item_id
  end
end
