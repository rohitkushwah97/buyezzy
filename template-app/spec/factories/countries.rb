FactoryBot.define do
  factory :country, class: 'AccountBlock::Country' do
    name {Faker::Name.unique.name}
  end
end

