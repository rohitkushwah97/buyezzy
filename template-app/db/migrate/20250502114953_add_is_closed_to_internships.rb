class AddIsClosedToInternships < ActiveRecord::Migration[6.1]
  def change
    add_column :bx_block_navmenu_internships, :is_closed, :boolean, default: false
  end
end
