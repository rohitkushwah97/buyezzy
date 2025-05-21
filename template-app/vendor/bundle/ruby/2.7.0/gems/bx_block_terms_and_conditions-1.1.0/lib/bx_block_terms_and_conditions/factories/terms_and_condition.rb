FactoryBot.define do
  factory :terms_and_condition, class: "BxBlockTermsAndConditions::TermsAndCondition" do
    account
    description { "Terms and conditions description" }
  end
end
