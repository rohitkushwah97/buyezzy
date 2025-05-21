class CreateInvoiceBilling < ActiveRecord::Migration[6.0]
  def change
    create_table :invoice_billings do |t|
      t.string :invoice_number
      t.references :order, null: false, foreign_key: { to_table: :shopping_cart_orders }
      t.references :order_item, null: false, foreign_key: { to_table: :shopping_cart_order_items }
      t.references :customer, null: false, foreign_key: { to_table: :accounts }
      t.index :invoice_number

      t.timestamps
    end
  end
end
