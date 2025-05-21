# Protected File
class ReNameBlockedAccountToCurrentUserId < ActiveRecord::Migration[6.0]
  def change
    rename_column :block_users, :blocked_account, :current_user_id
  end
end
