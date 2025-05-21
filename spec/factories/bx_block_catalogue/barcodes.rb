FactoryBot.define do
  factory :barcode, class: 'BxBlockCatalogue::Barcode' do
    bar_code { Faker::Lorem.word + rand(1..10000).to_s }
    catalogue
    status { false }
  end
end
