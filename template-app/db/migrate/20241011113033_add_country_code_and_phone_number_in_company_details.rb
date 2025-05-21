class AddCountryCodeAndPhoneNumberInCompanyDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :company_details, :country_code, :integer
    add_column :company_details, :phone_number, :bigint
  end
end
