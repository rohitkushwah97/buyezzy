# Protected File
class CreateBxBlockBlockUsersBlockUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :block_users do |t|
      t.references :account, null: false, index: false
      t.bigint    :blocked_account, null: false, index: false
      t.timestamps
    end
  end
end
