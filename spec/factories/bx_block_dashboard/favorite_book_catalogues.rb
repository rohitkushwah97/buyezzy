FactoryBot.define do
  factory :favorite_book_catalogue, class: "BxBlockDashboard::AuthorFavoriteBookCatalogue" do
    catalogue
    author_favorite_book
  end
end
