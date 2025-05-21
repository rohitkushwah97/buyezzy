class CreateBxBlockAddfriendsConnections < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_addfriends_connections do |t|
      t.references :account, null: false, foreign_key: true
      t.integer :receipient_id
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end

