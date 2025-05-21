class CreateDeliveryRequest < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_requests do |t|
      t.bigint :warehouse_id
      t.string :warehouse_name
      t.string :order_number
      t.string :address_1
      t.string :address_2
      t.text :geo_location
      t.string :status
      t.bigint :seller_id
      t.bigint :order_id

      t.index :warehouse_id
      t.index :warehouse_name
      t.index :order_number
      t.index :status
      t.index :seller_id
      t.index :order_id

      t.timestamps
    end
  end
end
