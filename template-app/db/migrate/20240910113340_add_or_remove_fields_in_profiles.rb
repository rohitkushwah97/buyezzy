class AddOrRemoveFieldsInProfiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :country
    remove_column :profiles, :city
    add_column :profiles, :country_id, :bigint
    add_column :profiles, :city_id, :bigint
  end
end
