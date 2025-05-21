class AddCurrentOrderColumnToAccount < ActiveRecord::Migration[6.0]
  def change
  	add_column :accounts, :current_order, :integer
  end
end
