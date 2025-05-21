class CreateGroupAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :group_attributes do |t|
      t.references :product_variant_group, null: false, foreign_key: true
      t.string :attribute_name
      t.string :option
      t.index :attribute_name
      t.index :option

      t.timestamps
    end
  end
end
