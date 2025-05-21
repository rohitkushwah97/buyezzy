FactoryBot.define do
  factory :privacy_policy, class: BxBlockTermsAndConditions::PrivacyPolicy do
    account_type {"Intern"}
    description {"description of privacy policy"}
  end
end