class CreateAttributeOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :attribute_options do |t|
      t.string :option
      t.references :variant_attribute, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
    add_index :attribute_options, :option
  end
end
