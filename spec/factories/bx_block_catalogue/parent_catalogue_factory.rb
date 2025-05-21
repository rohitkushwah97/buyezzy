FactoryBot.define do
  factory :parent_catalogue ,class: 'BxBlockCatalogue::ParentCatalogue'do
    sku {Faker::Alphanumeric.alpha(number: 5)}
    besku {Faker::Alphanumeric.alpha(number: 10)}
    product_title {Faker::Name.unique.name}
    product_image {Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','files', 'Sample.jpg'))}
    category
    brand
    prod_model_no {Faker::Alphanumeric.alpha(number: 5).upcase}
    details {"string"}
    status { false }
  end
end
