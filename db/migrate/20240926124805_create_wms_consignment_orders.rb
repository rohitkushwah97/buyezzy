class CreateWmsConsignmentOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :wms_consignment_orders do |t|
      t.string :order_number
      t.references :seller, null: false, foreign_key: { to_table: :accounts }
      t.references :catalogue, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price

      t.index :order_number
      t.index :quantity
      t.index :unit_price

      t.timestamps
    end
  end
end
