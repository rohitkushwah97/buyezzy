class RemoveIsWithdrawAndIsTerminateFieldsFromInternships < ActiveRecord::Migration[6.1]
  def change
    remove_column :bx_block_navmenu_internships, :is_withdraw, :boolean
    remove_column :bx_block_navmenu_internships, :is_terminate, :boolean
  end
end
