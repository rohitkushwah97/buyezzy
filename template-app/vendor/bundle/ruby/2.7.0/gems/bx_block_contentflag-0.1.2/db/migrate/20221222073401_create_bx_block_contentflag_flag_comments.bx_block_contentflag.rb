class CreateBxBlockContentflagFlagComments < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_contentflag_flag_comments do |t|
      t.integer :account_id
      t.integer :post_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
