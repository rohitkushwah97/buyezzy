# This migration comes from bx_block_like_a_post (originally 20200925125727)
class CreateLikePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :like_posts do |t|
      t.references :account, foreign_key: true
      t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
