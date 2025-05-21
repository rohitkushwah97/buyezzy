FactoryBot.define do
  factory :review, class: 'BxBlockCatalogue::Review' do
    title { Faker::Lorem.paragraph }
    description {  Faker::Lorem.paragraph(sentence_count: 3) }
    rating { Faker::Number.between(from: 1, to: 5) }
    review_type { 'product' }
    association :account, factory: :account
    association :catalogue, factory: :catalogue
  end
end