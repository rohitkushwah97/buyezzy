class AddOrRemoveAttributesinInternships < ActiveRecord::Migration[6.1]
  def change
    remove_column :bx_block_navmenu_internships, :educational_status_id
    add_column :bx_block_navmenu_internships, :educational_statuses, :integer, array: true, default: []
  end
end
