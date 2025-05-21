class AddStatusToAuthorFavoriteBook < ActiveRecord::Migration[6.0]
  def change
  	add_column :author_favorite_books, :status, :boolean, default: false
  end
end
