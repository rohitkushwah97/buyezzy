class CreateDealCatalogues < ActiveRecord::Migration[6.0]
  def change
    create_table :deal_catalogues do |t|
      t.references :deal, null: false, foreign_key: true
      t.references :catalogue, null: false, foreign_key: true
      t.integer :status, default: 0
      t.decimal :deal_price

      t.timestamps
    end
  end
end
