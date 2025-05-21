class ProjectreportingCreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_projectreporting_projects do |t|
      t.string "name"
      t.bigint "manager_id"
      t.bigint "account_id"
      t.bigint "co_manager_id"
      t.integer "online_tool_ids", default: [], array: true
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "project_type", default: 0
      t.integer "client_id"
      t.datetime "start_date"
      t.datetime "end_date"
      t.integer "assessor_ids", default: [], array: true
      t.decimal "max_score", precision: 10, scale: 2, default: "0.0"
      t.integer "assessor_tool_ids", default: [], array: true
      t.boolean "is_negative_marking", default: false
      t.decimal "negative_mark", precision: 10, scale: 2
      t.integer "question_ids", default: [], array: true
      t.integer "duration"
      t.integer "competancy_ids", default: [], array: true 
      t.index ["account_id"], name: "index_bx_block_projectreporting_projects_on_account_id"
    end
  end
end
