class AddKeysToInternships < ActiveRecord::Migration[6.1]
  def change
    add_column :bx_block_navmenu_internships, :is_withdraw, :boolean, default: false
    add_column :bx_block_navmenu_internships, :is_terminate, :boolean, default: false
  end
end
