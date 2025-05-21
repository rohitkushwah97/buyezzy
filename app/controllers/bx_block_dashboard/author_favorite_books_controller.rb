module BxBlockDashboard
	class AuthorFavoriteBooksController < ApplicationController
		before_action :load_author_favorite_book, only: [:show]

		def index
			@author_favorite_books = AuthorFavoriteBook.all

			render json: AuthorFavoriteBookSerializer.new(@author_favorite_books)
		end

		def show
			render json: AuthorFavoriteBookSerializer.new(@author_favorite_book)
		end

		def latest_author_favorite
			@author_favorite_book = AuthorFavoriteBook.order(created_at: :desc).find_by(status: true)

			render json: AuthorFavoriteBookSerializer.new(@author_favorite_book)
		end

		private

		def load_author_favorite_book
			@author_favorite_book = AuthorFavoriteBook.find_by(id: params[:id])
		end

	end
end
