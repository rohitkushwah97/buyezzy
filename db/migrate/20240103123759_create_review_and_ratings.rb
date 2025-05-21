class CreateReviewAndRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :review_and_ratings do |t|
      t.string :title
      t.text :description
      t.integer :rating
      t.integer :catalogue_id
      t.integer :reviewer_id
      t.string :review_type
      t.integer :account_id, null: true
      t.boolean :is_approved, default: false
      t.timestamps
    end
  end
end
