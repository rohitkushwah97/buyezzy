class CreateBxBlockLikeAPostRestrictedWords < ActiveRecord::Migration[6.1]
  def change
    create_table :bx_block_like_a_post_restricted_words do |t|
      t.string :word,

      t.timestamps
    end
  end
end
