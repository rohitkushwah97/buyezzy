class CreateVariantAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :variant_attributes do |t|
      t.string :attribute_name
      t.references :catalogue_variant, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
    add_index :variant_attributes, :attribute_name
  end
end
