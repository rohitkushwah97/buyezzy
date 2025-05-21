FactoryBot.define do
  factory :author_favorite_book, class: "BxBlockDashboard::AuthorFavoriteBook" do
    title { "MyString" }
    status {true}
  end
end
