def uploaded_image(file_name = 'Sample.jpg')
  Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', file_name))
end

FactoryBot.define do
  factory :category ,class: 'BxBlockCategories::Category'do
    name { Faker::Lorem.characters(number: 10, min_alpha: 4) }
    category_image { uploaded_image }
    header_image { uploaded_image }
  end
end
