FactoryBot.define do
  factory :report, class: 'BxBlockProfile::Report' do
    title { 'Misleading or false information' }
    description { 'This report is about false information.' }

    association :created_by, factory: :account
    association :created_for, factory: :account

    trait :inappropriate_content do
      title { 'Inappropriate content' }
      description { 'This report is about inappropriate content.' }
    end

    trait :discrimination_or_hate_speech do
      title { 'Discrimination or hate speech' }
      description { 'This report is about hate speech.' }
    end
  end
end
