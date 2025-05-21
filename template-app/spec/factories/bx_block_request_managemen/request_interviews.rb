# spec/factories/request_interviews.rb
FactoryBot.define do
  factory :request_interview, class: 'BxBlockRequestManagement::RequestInterview' do
    association :intern_user, factory: :intern_user, strategy: :build
    association :business_user, factory: :business_user, strategy: :build
    association :internship, factory: :bx_block_navmenu_internship, strategy: :build

    number_of_days { rand(3..7) }
    status { :pending }

    trait :accepted do
      status { :accepted }
    end

    trait :rejected do
      status { :rejected }
    end
  end
end
