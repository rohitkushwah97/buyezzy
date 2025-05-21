class CreateBxBlockChatPromptVersions < ActiveRecord::Migration[6.1]
  def change
    create_table :prompt_versions do |t|
      t.string :name
      t.text :description
      t.bigint "prompt_manager_id", null: false
      t.index ["prompt_manager_id"], name: "index_prompt_versions_on_prompt_manager_id"
      t.timestamps
    end
  end
end
