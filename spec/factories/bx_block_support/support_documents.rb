FactoryBot.define do
  factory :support_document, class: 'BxBlockSupport::SupportDocument' do
    page_title { Faker::Lorem.word + rand(1..10000).to_s}
    content { Faker::Lorem.word }
  end
end
