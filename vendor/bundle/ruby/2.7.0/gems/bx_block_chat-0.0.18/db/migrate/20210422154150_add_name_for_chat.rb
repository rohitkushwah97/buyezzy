class AddNameForChat < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :name, :string, null: false, default: ""
  end
end
