class CreateAuthorFavoriteBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :author_favorite_books do |t|
      t.string :title
      t.index :title

      t.timestamps
    end
  end
end
