FactoryBot.define do
  factory :privacy_and_legal_policy, class: 'BxBlockTermsandconditions::PrivacyAndLegalPolicy' do
    title { Faker::Lorem.word + rand(1..10000).to_s }
    content { "privacy content body" }
    status { true }
  end
end
