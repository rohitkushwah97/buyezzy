class AddDurationinInternships < ActiveRecord::Migration[6.1]
  def change
    add_column :bx_block_navmenu_internships, :duration, :integer, default: 0
  end
end
