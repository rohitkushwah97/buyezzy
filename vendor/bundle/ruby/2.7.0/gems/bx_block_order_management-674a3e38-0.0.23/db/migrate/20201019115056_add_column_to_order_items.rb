# frozen_string_literal: true

class AddColumnToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :order_status_id, :integer
    add_column :order_items, :placed_at, :datetime
    add_column :order_items, :confirmed_at, :datetime
    add_column :order_items, :in_transit_at, :datetime
    add_column :order_items, :delivered_at, :datetime
    add_column :order_items, :cancelled_at, :datetime
    add_column :order_items, :refunded_at, :datetime
    add_column :order_items, :manage_placed_status, :boolean, default: false
    add_column :order_items, :manage_cancelled_status, :boolean, default: false
  end
end
