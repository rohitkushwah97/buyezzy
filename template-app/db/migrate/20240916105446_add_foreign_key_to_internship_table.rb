class AddForeignKeyToInternshipTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :bx_block_navmenu_internships, :industry, foreign_key: { to_table: :industries }
    add_reference :bx_block_navmenu_internships, :role, foreign_key: { to_table: :roles }
    add_reference :bx_block_navmenu_internships, :work_location, foreign_key: { to_table: :work_locations }
    add_reference :bx_block_navmenu_internships, :work_schedule, foreign_key: { to_table: :work_schedules }
    add_reference :bx_block_navmenu_internships, :country, foreign_key: { to_table: :countries }
    add_reference :bx_block_navmenu_internships, :city, foreign_key: { to_table: :cities }
    add_reference :bx_block_navmenu_internships, :educational_status, foreign_key: { to_table: :educational_statuses }
  end
end
