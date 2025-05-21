FactoryBot.define do
  factory :inquiry_details, class: BxBlockHelpCentre::ContactUs do
    full_name { Faker::Commerce.department }
    email { Faker::Internet.unique.email }
    inquiry_details { "I need help with my account." }
    association :issue_type, factory: :issue_type
  end
end