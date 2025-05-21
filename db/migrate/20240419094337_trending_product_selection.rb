class TrendingProductSelection < ActiveRecord::Migration[6.0]
  def change
  	create_table :trending_product_selections do |t|
      t.references :trending_product, null: false, foreign_key: true
      t.references :catalogue, null: false, foreign_key: true
      t.timestamps
    end
  end
end
