class CreateActivityLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_logs do |t|
      t.references :user, null: true, foreign_key: { to_table: :accounts, on_delete: :nullify }
      t.string :user_email
      t.string :user_type
      t.datetime :accessed_at
      t.string :action
      t.text :details
      t.index :user_type
      t.index :accessed_at
      t.index :action

      t.timestamps
    end
  end
end
