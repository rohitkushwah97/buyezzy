class AddUpdateByToCompantyDetail < ActiveRecord::Migration[6.1]
  def up
    add_column :company_details, :update_by, :string
   
  end

  def down
    remove_column :company_details, :update_by, :string
  end
end
