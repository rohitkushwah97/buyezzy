FactoryBot.define do
  factory :static_page, class: 'BxBlockSupport::StaticPage' do
    title { Faker::Lorem.word + rand(1..10000).to_s }
    content { "MyText" }
    status { true }
  end
end
