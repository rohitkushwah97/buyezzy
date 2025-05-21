class AddColumnToAddresses < ActiveRecord::Migration[6.0]
  def change
  	add_column :addresses, :city, :string
  	add_column :addresses, :state, :string
    add_column :addresses, :email, :string
    add_column :addresses, :contact_number, :string
    add_column :addresses, :seller_id, :integer
  end
end
