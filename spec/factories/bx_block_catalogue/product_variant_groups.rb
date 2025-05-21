FactoryBot.define do
  factory :product_variant_group, class: 'BxBlockCatalogue::ProductVariantGroup' do
    product_sku { Faker::Alphanumeric.alpha(number: 5) }
    product_bibc { Faker::Alphanumeric.alpha(number: 8) }
    product_description {Faker::Lorem.sentence(word_count: 3)} 
    price { "500" } 
    product_title {Faker::Lorem.word}
    product_images {Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','files', 'Sample.jpg'))}
    catalogue
  end
end
