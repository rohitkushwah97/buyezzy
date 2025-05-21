class AddColumnToAccount < ActiveRecord::Migration[6.0]
  def change
  	add_column :accounts, :company_or_store_name, :string
  end
end
