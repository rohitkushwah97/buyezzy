FactoryBot.define do
  factory :flag_category, class: 'BxBlockContentflag::FlagCategory' do
    reason {(0...15).map { ('a'..'z').to_a[rand(26)] }.join}
  end
end