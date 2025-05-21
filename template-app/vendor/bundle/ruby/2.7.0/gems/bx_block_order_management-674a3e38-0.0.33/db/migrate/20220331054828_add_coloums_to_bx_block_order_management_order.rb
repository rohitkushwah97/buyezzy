# frozen_string_literal: true

class AddColoumsToBxBlockOrderManagementOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :order_management_orders, :charged, :boolean
    add_column :order_management_orders, :invoiced, :boolean
    add_column :order_management_orders, :invoice_id, :string
  end
end
