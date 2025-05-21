FactoryBot.define do
  factory :city, class: 'AccountBlock::City' do
    name {Faker::Name.unique.name}
    country { FactoryBot.create(:country)}
  end
end
