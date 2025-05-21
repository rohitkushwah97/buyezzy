class ModifyUserDeliveryAddresses < ActiveRecord::Migration[6.0]
  def change
  	# Remove unwanted columns
    remove_column :user_delivery_addresses, :full_name
    remove_column :user_delivery_addresses, :mobile_number
    remove_column :user_delivery_addresses, :country
    remove_column :user_delivery_addresses, :street_address
    remove_column :user_delivery_addresses, :building_name_no
    remove_column :user_delivery_addresses, :area
    remove_column :user_delivery_addresses, :landmark

    # Add new columns
    add_column :user_delivery_addresses, :first_name, :string
    add_column :user_delivery_addresses, :last_name, :string
    add_column :user_delivery_addresses, :address_1, :string
    add_column :user_delivery_addresses, :address_2, :string
    add_column :user_delivery_addresses, :phone_number, :string
    add_column :user_delivery_addresses, :zip_code, :string
  end
end
