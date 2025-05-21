class RemoveCategoryForeignKeyFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :posts, :categories
  end
end
