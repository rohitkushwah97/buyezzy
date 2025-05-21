class AddWarrantyColumnToProductContent < ActiveRecord::Migration[6.0]
  def change
    add_column :product_contents, :warranty_days, :integer
    add_column :product_contents, :warranty_months, :integer
    add_index :product_contents, :warranty_months
    add_index :product_contents, :warranty_days
  end
end
