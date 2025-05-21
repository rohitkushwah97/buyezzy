class CreateWmsProductInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :wms_product_infos do |t|
      t.references :seller, null: false, foreign_key: { to_table: :accounts }
      t.references :catalogue, null: false, foreign_key: true
      t.string :product_information_id
      t.string :product_dimensions_info
      t.index :product_information_id
      t.index :product_dimensions_info

      t.timestamps
    end
  end
end
