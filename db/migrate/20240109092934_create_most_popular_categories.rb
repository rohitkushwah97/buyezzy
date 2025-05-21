class CreateMostPopularCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :most_popular_categories do |t|
      t.integer :sequence_no
      t.references :category, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
