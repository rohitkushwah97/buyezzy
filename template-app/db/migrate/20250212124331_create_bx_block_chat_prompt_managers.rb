class CreateBxBlockChatPromptManagers < ActiveRecord::Migration[6.1]
  def change
    create_table :prompt_managers do |t|
      t.text :criteria
      t.timestamps
    end
  end
end
