class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer :account_id
      t.integer :follow_id

      t.timestamps
    end
    add_index :follows, :account_id
    add_index :follows, :follow_id
    add_index :follows, [:account_id, :follow_id], unique: true
  end
end
