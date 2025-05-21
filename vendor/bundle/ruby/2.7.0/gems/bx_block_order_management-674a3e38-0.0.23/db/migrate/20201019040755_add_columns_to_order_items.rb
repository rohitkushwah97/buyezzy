# frozen_string_literal: true

class AddColumnsToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_items, :catalogue, null: false, foreign_key: true
    add_reference :order_items, :catalogue_variant, null: false, foreign_key: true
  end
end
