class AddIndustryFkInRoles < ActiveRecord::Migration[6.1]
  def change
    add_column :roles, :industry_id, :bigint
  end
end
