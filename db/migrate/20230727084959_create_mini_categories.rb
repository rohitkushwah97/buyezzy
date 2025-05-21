class CreateMiniCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :mini_categories do |t|
      t.string :name

      t.timestamps
    end
    add_column :mini_categories, :sub_category_id, :integer
    add_index :mini_categories, :name
    add_index :mini_categories, :id
  end
end
