# Protected File
class AddChatTypeToChats < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :chat_type, :integer, null: false
  end
end
