class CreateMicroCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :micro_categories do |t|
      t.string :name
      t.integer :mini_category_id

      t.timestamps
    end
    add_index :micro_categories, :name
    add_index :micro_categories, :id
  end
end
