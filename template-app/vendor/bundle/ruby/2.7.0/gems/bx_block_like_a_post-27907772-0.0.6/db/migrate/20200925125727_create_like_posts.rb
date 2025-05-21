class CreateLikePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :like_posts do |t|
      t.references :account, foreign_key: true
      t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
