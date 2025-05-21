class ChatbotResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :chatbot_responses do |t|
      t.references :chatbot_interview, null: false, foreign_key: true
      t.integer :prompt_index # Index of the question asked
      t.text :question
      t.text :answer
      t.text :asked_by
      t.timestamps
    end
  end
end
