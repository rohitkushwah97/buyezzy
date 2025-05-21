FactoryBot.define do
  factory :term_and_condition, class: BxBlockTermsAndConditions::TermsAndCondition do
    account_type {"Intern"}
    description {"description of terms and condition"}
  end
end