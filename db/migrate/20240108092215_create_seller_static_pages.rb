class CreateSellerStaticPages < ActiveRecord::Migration[6.0]
  def change
    create_table :seller_static_pages do |t|
      t.string :title
      t.text :content
      t.boolean :status, default: false
      t.index :title

      t.timestamps
    end
  end
end
