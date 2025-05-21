class RemoveUnusefulFieldsFromCatalogue < ActiveRecord::Migration[6.0]
  def change
    remove_column :catalogues, :name, :string
    remove_column :catalogues, :description, :string
    remove_column :catalogues, :manufacture_date, :datetime
    remove_column :catalogues, :length, :float
    remove_column :catalogues, :breadth, :float
    remove_column :catalogues, :height, :float
    remove_column :catalogues, :availability, :integer
    remove_column :catalogues, :stock_qty, :integer
    remove_column :catalogues, :weight, :decimal
    remove_column :catalogues, :price, :float
    remove_column :catalogues, :recommended, :boolean
    remove_column :catalogues, :on_sale, :boolean
    remove_column :catalogues, :sale_price, :decimal
    remove_column :catalogues, :discount, :decimal
    remove_column :catalogues, :block_qty, :integer
  end
end
