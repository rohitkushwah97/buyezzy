class AddorRemoveColumnToBrand < ActiveRecord::Migration[6.0]
  def change
  	remove_column :brands, :currency, :integer
  	remove_column :brands, :name, :string
  	add_column :brands, :brand_name, :string
    add_column :brands, :brand_name_arabic, :string
    add_column :brands, :brand_website, :string
    add_column :brands, :brand_year, :integer
    add_reference :brands, :account, foreign_key: true
  end
end
