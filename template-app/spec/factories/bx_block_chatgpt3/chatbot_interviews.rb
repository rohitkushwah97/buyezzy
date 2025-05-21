FactoryBot.define do
  factory :chatbot_interview, class: 'BxBlockChatgpt3::ChatbotInterview' do
    association :intern_user
    association :prompt_version
    start_time { Time.current }
    status { 'ongoing' }
    end_time { nil }
    termination_reason { nil }
  end
end
