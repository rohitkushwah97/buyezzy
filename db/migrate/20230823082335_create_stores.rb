class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :store_name
      t.integer :store_year
      t.string :store_url
      t.string :website_social_url

      t.references :brand

      t.timestamps
    end
  end
end
