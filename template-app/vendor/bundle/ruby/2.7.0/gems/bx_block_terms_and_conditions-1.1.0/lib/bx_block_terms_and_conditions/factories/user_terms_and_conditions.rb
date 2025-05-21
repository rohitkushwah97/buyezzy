FactoryBot.define do
  factory :user_terms_and_conditions, class: "BxBlockTermsAndConditions::UserTermAndCondition" do
    account_id { FactoryBot.create(:account, first_name: "first", last_name: "last").id }
    terms_and_condition_id { FactoryBot.create(:terms_and_condition).id }
    is_accepted { true }
  end
end
