# frozen_string_literal: true

class CreateBxBlockOrderManagementOrderTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :order_transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.references :order_management_order, null: false, foreign_key: true
      t.string :charge_id
      t.integer :amount
      t.string :currency
      t.string :charge_status

      t.timestamps
    end
  end
end
