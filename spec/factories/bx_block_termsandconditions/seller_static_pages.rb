FactoryBot.define do
  factory :seller_static_page, class: 'BxBlockTermsandconditions::SellerStaticPage' do
    title { Faker::Lorem.word + rand(1..10000).to_s}
    content { Faker::Lorem.word }
    section { 'header' }
    status { false }
  end
end
