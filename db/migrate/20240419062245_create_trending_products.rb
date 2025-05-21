class CreateTrendingProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :trending_products do |t|
      t.integer :slider

      t.timestamps
    end
  end
end
