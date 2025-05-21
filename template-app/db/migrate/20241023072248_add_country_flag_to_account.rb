class AddCountryFlagToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :country_flag, :string
    add_column :company_details, :country_flag, :string
  end
end
