# Protected File
class AddShare < ActiveRecord::Migration[6.0]
  def change
    create_table :share_records do |t|
      t.references :post, foreign_key: true
      t.references :account, foreign_key: true
      t.integer :shared_to_id, null: false
      t.timestamps
    end
  end
end
