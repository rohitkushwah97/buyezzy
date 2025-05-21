class UpdateUserDeliveryAddressesDefault < ActiveRecord::Migration[6.0]
  def change
  	change_column_default :user_delivery_addresses, :is_default, from: nil, to: false
  end
end
