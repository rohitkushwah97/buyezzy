FactoryBot.define do
  factory :chatbot_response, class: 'BxBlockChatgpt3::ChatbotResponse' do
    association :chatbot_interview
    prompt_index { rand(1..10) }
    question { "What is Ruby on Rails?" }
    answer { "A server-side web application framework written in Ruby." }
    asked_by { ["system", "intern"].sample }
  end
end
