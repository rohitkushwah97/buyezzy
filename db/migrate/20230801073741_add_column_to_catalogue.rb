class AddColumnToCatalogue < ActiveRecord::Migration[6.0]
  def change
    add_column :catalogues, :new_stock, :integer
    add_column :catalogues, :processing_time, :string
    add_column :catalogues, :besku, :string
    add_column :catalogues, :status, :boolean
    add_column :catalogues, :warehouse_id, :bigint
  end
end
