FactoryBot.define do
  factory :issue_type, class: 'BxBlockHelpCentre::IssueType' do
    name { Faker::Commerce.department }
  end
end