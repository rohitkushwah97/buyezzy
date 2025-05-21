class AddColumnToAccountsBxBlockNavmenuInternships < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts_bx_block_navmenu_internships, :status, :string, default: "pending"
    add_index :accounts_bx_block_navmenu_internships, :status
    add_column :accounts_bx_block_navmenu_internships, :created_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :accounts_bx_block_navmenu_internships, :updated_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
