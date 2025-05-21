FactoryBot.define do
  factory :brand ,class: 'BxBlockCatalogue::Brand'do
    brand_name { Faker::Lorem.word + rand(1..20000).to_s + Faker::Lorem.word}
    brand_name_arabic { Faker::Lorem.word + rand(1..10000).to_s }
    brand_website {"www.#{Faker::Lorem.word}.com"}
    brand_year {rand(1900..2023)}
    brand_image {Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','files', 'Sample.jpg'))}
    branding_tradmark_certificate {}
    approve { true }
    restricted { false }
    gated { false }
    account
  end
end
