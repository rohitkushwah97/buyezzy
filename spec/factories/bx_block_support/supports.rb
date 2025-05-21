FactoryBot.define do
  factory :support, class: 'BxBlockSupport::Support' do
    first_name { "MyString" }
    last_name { "MyString" }
    email { Faker::Internet.email }
    details { "MyText" }
  end
end
