class CreateTopBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :top_brands do |t|
      t.integer :sequence_no
      t.references :brand, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
