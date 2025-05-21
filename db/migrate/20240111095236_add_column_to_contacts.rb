class AddColumnToContacts < ActiveRecord::Migration[6.0]
  def change
  	remove_column :contacts, :account_id, :integer
  	add_column :contacts, :contact_type, :string
  	add_column :contacts, :last_name, :string
    add_column :contacts, :title, :string
    rename_column :contacts, :name, :first_name
  end
end
