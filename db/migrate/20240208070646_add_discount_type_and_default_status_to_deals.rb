class AddDiscountTypeAndDefaultStatusToDeals < ActiveRecord::Migration[6.0]
  def change
    add_column :deals, :discount_type, :string
    change_column_default :deals, :status, from: nil, to: false
  end
end
