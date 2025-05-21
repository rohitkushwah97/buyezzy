class CreateProductContents < ActiveRecord::Migration[6.0]
  def change
    create_table :product_contents do |t|
      t.string :gtin
      t.string :unique_psku
      t.string :brand_name
      t.string :product_title
      t.decimal :mrp, precision: 10, scale: 2
      t.decimal :retail_price, precision: 10, scale: 2
      t.text :long_description
      t.string :whats_in_the_package
      t.string :country_of_origin
      t.string :dispenser_type
      t.string :scent_type
      t.string :target_use
      t.string :style_name
      t.references :catalogue, null: false, foreign_key: true

      t.timestamps
    end
  end
end
