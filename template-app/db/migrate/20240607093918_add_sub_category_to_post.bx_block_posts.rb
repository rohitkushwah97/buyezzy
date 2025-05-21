# This migration comes from bx_block_posts (originally 20230221133918)
# Protected File
class AddSubCategoryToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :sub_category_id, :bigint, index: true
  end
end
