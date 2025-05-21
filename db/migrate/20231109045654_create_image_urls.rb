class CreateImageUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :image_urls do |t|
      t.string :url
      t.references :product_content, null: false, foreign_key: true

      t.timestamps
    end
  end
end
