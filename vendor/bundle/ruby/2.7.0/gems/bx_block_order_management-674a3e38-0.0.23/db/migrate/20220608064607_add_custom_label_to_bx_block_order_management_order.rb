# frozen_string_literal: true

class AddCustomLabelToBxBlockOrderManagementOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :order_management_orders, :custom_label, :string
  end
end
