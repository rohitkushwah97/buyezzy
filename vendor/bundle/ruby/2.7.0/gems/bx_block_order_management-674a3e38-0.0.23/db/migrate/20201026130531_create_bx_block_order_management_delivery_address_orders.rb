# frozen_string_literal: true

class CreateBxBlockOrderManagementDeliveryAddressOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_address_orders do |t|
      t.references :order_management_order, null: false, foreign_key: true
      t.references :delivery_address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
