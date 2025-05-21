FactoryBot.define do
  factory :terms_policy ,class: 'BxBlockTermsandconditions::TermsPolicy'do
    page_title { Faker::Lorem.word + rand(1..10000).to_s}
    content { Faker::Lorem.word }
  end
end
