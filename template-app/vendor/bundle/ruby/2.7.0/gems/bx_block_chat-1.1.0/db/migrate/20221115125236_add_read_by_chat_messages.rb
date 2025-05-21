# Protected File
class AddReadByChatMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_messages, :read_by, :integer, array: true, default: []
  end
end
