class AddDeadlineDateToInternships < ActiveRecord::Migration[6.1]
  def change
    add_column :bx_block_navmenu_internships, :deadline_date, :datetime
  end
end
