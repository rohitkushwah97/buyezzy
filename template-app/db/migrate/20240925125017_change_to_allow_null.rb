class ChangeToAllowNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :company_details, :country_id, true
    change_column_null :company_details, :industry_id, true
    change_column_null :company_details, :city_id, true
    change_column_null :company_details, :business_user_id, true    
  end
end
