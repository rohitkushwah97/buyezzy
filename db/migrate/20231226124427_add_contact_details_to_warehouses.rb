class AddContactDetailsToWarehouses < ActiveRecord::Migration[6.0]
  def change
    add_column :warehouses, :contact_number, :string
    add_column :warehouses, :contact_person, :string
    add_column :warehouses, :processing_days, :integer
    add_column :warehouses, :account_id, :integer, null: true, default: nil
  end
end
