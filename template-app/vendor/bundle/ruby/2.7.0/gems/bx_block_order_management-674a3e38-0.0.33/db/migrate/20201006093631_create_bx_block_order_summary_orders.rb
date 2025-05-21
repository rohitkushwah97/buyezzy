# frozen_string_literal: true

class CreateBxBlockOrderSummaryOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :order_management_orders do |t|
      t.string :order_number
      t.float :amount
      t.timestamps
    end
  end
end
