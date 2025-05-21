FactoryBot.define do
  factory :catalogue, class: 'BxBlockCatalogue::Catalogue' do
    sku { Faker::Alphanumeric.alphanumeric(number: 14, min_numeric: 5) }
    bibc { Faker::Alphanumeric.alpha(number: 8) }
    product_title { Faker::Name.unique.name }
    product_image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'Sample.jpg')) }
    fulfilled_type {'partner'}
    product_type {'standard'}
    content_status {'in_progress'}
    stocks {5}
    category
    brand
    parent_catalogue
    status { false }

    after(:build) do |catalogue|
      if catalogue.parent_catalogue.present?
        catalogue.besku = catalogue.parent_catalogue.besku
      end
    end
  end
end
