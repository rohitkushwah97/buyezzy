module BxBlockChatgpt3
  class ChatbotResponse < ApplicationRecord
    belongs_to :chatbot_interview
    enum asked_by: { system: "system", intern: "intern" }
  end
end
