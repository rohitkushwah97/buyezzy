# frozen_string_literal: true

class AddRazorpayOrderIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :order_management_orders, :razorpay_order_id, :string
  end
end
