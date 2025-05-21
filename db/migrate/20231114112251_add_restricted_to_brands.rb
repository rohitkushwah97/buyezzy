class AddRestrictedToBrands < ActiveRecord::Migration[6.0]
  def change
    add_column :brands, :restricted, :boolean, default: false
    add_column :brands, :gated, :boolean, default: false
  end
end
