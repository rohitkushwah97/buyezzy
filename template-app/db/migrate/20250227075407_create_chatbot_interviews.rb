class CreateChatbotInterviews < ActiveRecord::Migration[6.1]
  def change
    create_table :chatbot_interviews do |t|
      t.references :account, null: false, foreign_key: { to_table: :accounts }
      t.references :prompt_version, null: false, foreign_key: true
      # t.references :request_interview, foreign_key: { to_table: :request_interviews }
      t.bigint :request_interview_id, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.string :status, null: false
      t.string :termination_reason

      t.timestamps
    end
  end
end