class CreateCatalogueOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :catalogue_offers do |t|
      t.decimal :price_info
      t.decimal :sale_price
      t.bigint :barcode_id
      t.string :bar_code_info
      t.date :sale_schedule_from
      t.date :sale_schedule_to
      t.string :warranty
      t.string :comments
      t.boolean :status
      t.references :catalogue, foreign_key: true

      t.timestamps
    end
  end
end