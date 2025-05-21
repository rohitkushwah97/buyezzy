FactoryBot.define do
  factory :work_schedule, class: 'BxBlockSettings::WorkSchedule' do
    sequence(:schedule) { |n| "#{Faker::Name.name} #{n}" }
  end
end