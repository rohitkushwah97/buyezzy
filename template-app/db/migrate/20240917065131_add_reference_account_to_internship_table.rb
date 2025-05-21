class AddReferenceAccountToInternshipTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :bx_block_navmenu_internships, :business_user, foreign_key: { to_table: :accounts }
  end
end
