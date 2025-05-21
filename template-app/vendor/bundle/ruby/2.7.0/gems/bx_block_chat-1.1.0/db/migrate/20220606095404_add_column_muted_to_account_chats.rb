# Protected File
class AddColumnMutedToAccountChats < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts_chats, :muted, :boolean, default: false
  end
end
