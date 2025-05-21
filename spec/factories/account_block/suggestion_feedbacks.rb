FactoryBot.define do
  factory :suggestion_feedback ,class: 'AccountBlock::SuggestionFeedback'do
    detail_type { "MyString" }
    detail { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
  end
end
