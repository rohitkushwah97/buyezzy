FactoryBot.define do
  factory :bx_block_navmenu_internship, class: 'BxBlockNavmenu::Internship' do
    start_date { "2024-09-16" }
    end_date { "2024-12-31" }
    deadline_date { Date.today + 7.days }
    title { Faker::Job.title }
    description { Faker::Lorem.paragraph }
    monthly_salary { 1000 }
    association :industry
    association :role
    association :work_location
    association :work_schedule
    association :country
    association :city
    #association :educational_status
    association :business_user
    
  end
end

