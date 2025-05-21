class AddFlagStatusInContentFlag < ActiveRecord::Migration[6.0]
  def change
    add_column :bx_block_contentflag_contents, :approved, :boolean, default: false
    add_column :bx_block_contentflag_flag_comments, :approved, :boolean, default: false
    add_column :bx_block_contentflag_flag_comments, :flag_category_id, :bigint
    add_column :comments, :actived, :boolean, default: true
  end
end
