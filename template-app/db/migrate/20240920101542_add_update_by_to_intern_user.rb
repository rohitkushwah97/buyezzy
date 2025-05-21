class AddUpdateByToInternUser < ActiveRecord::Migration[6.1]
 def up
    add_column :accounts, :update_by, :string
   
  end

  def down
    remove_column :accounts, :update_by, :string
  end
end
