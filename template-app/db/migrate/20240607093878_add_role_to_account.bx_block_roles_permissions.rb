# This migration comes from bx_block_roles_permissions (originally 20200924131313)
# Protected File
class AddRoleToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :role_id, :integer
  end
end
