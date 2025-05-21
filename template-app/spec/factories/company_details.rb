FactoryBot.define do
  factory :company_detail, class: 'BxBlockProfile::CompanyDetail' do
    company_name { Faker::Company.name }
    website_link { Faker::Internet.url }
    address { Faker::Address.full_address }
    company_description { Faker::Company.catch_phrase }
    country { FactoryBot.create(:country)}
    industry { FactoryBot.create(:industry) }
    city { FactoryBot.create(:city) }
    business_user { FactoryBot.create(:business_user) }
  end
end