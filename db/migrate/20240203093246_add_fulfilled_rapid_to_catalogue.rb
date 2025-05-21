class AddFulfilledRapidToCatalogue < ActiveRecord::Migration[6.0]
  def change
    add_column :catalogues, :fulfilled_type, :string
    add_column :catalogues, :product_type, :string, default: 'standard'
    add_column :catalogues, :content_status, :string
    add_column :catalogues, :stocks, :integer

    add_index :catalogues, :fulfilled_type
    add_index :catalogues, :product_type
    add_index :catalogues, :content_status
    add_index :catalogues, :stocks
  end
end
