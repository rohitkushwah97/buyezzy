class CreateBxBlockContentflagContents < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_contentflag_contents do |t|
      t.references :post, null: false
      t.references :account, null: false
      t.integer :flag_category_id

      t.timestamps
    end
  end
end
