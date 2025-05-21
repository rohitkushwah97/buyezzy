# This migration comes from bx_block_catalogue (originally 20221124101610)
# Protected File
class RemoveCurrencyFromBrand < ActiveRecord::Migration[6.0]
  def change
    remove_column :brands, :currency
  end
end
