class CreateShippingDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_details do |t|
      t.decimal :shipping_length
      t.string :shipping_length_unit
      t.decimal :shipping_height
      t.string :shipping_height_unit
      t.decimal :shipping_width
      t.string :shipping_width_unit
      t.decimal :shipping_weight
      t.string :shipping_weight_unit
      t.references :product_content, null: false, foreign_key: true

      t.timestamps
    end
  end
end
