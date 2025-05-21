FactoryBot.define do
  factory :helpful_review, class: 'BxBlockCatalogue::HelpfulReview' do
    association :customer, factory: :account
    review
  end
end