class AuthorFavoriteBookCatalogue < ActiveRecord::Migration[6.0]
  def change
  	create_table :favorite_book_catalogues do |t|
      t.references :author_favorite_book, null: false, foreign_key: true
      t.references :catalogue, null: false, foreign_key: true
      t.timestamps
    end
  end
end
