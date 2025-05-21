class AddIdToAccountsBxBlockNavmenuInternships < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts_bx_block_navmenu_internships, :id, :primary_key
  end
end
