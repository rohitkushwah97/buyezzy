# frozen_string_literal: true

class ChangeAmountToBeIntegerInOrderManagementOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :order_management_orders, :amount, :integer
  end
end
