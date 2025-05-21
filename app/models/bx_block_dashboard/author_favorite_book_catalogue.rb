module BxBlockDashboard
	class AuthorFavoriteBookCatalogue < ApplicationRecord
		self.table_name = :favorite_book_catalogues
		belongs_to :catalogue, class_name: 'BxBlockCatalogue::Catalogue'
		belongs_to :author_favorite_book, class_name: 'BxBlockDashboard::AuthorFavoriteBook'

	end
end