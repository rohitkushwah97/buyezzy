FactoryBot.define do
  factory :restricted_word, class: 'BxBlockLikeAPost::RestrictedWord' do
    word { "testword" }
  end
end