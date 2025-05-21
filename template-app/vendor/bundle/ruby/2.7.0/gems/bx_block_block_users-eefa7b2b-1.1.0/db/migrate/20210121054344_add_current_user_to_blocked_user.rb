# Protected File
class AddCurrentUserToBlockedUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :block_users, :current_user_id
    add_reference :block_users, :current_user, foreign_key: { to_table: :accounts }
  end
end
