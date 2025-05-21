FactoryBot.define do
  factory :prompt_version, class: 'BxBlockChat::PromptVersion' do
    name {Faker::Name.unique.name}
    description {"Fack description is here."}
    association :prompt_manager
  end
end