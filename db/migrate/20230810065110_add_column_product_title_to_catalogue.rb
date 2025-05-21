class AddColumnProductTitleToCatalogue < ActiveRecord::Migration[6.0]
  def change
    add_column :catalogues, :product_title, :string
  end
end
