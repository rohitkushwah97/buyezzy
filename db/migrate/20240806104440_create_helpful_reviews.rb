class CreateHelpfulReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :helpful_reviews do |t|
      t.references :review, null: false, foreign_key: { to_table: :review_and_ratings }
      t.references :customer, null: false, foreign_key: { to_table: :accounts }

      t.timestamps
    end

    add_index :helpful_reviews, [:review_id, :customer_id], unique: true
  end
end
