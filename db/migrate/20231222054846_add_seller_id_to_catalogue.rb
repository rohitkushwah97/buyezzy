class AddSellerIdToCatalogue < ActiveRecord::Migration[6.0]
  def change
    add_column :catalogues, :seller_id, :bigint
  end
end
