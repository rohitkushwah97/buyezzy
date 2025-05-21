class CreateUserDeliveryAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_delivery_addresses do |t|
      t.string :full_name
      t.string :mobile_number
      t.string :country
      t.string :street_address
      t.string :building_name_no
      t.string :city
      t.string :area
      t.string :landmark
      t.boolean :is_default
      t.string :address_type
      t.string :state
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
