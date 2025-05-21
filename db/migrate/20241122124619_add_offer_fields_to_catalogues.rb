class AddOfferFieldsToCatalogues < ActiveRecord::Migration[6.0]
  def change
    add_column :catalogues, :offer_percentage, :float, default: 0.0
    add_column :catalogues, :stroked_price, :float, default: 0.0
  end
end
