module BxBlockChatgpt3
  class ChatbotInterview < ApplicationRecord
    belongs_to :intern_user, class_name: 'AccountBlock::InternUser', foreign_key: 'account_id'
    belongs_to :request_interview, class_name: 'BxBlockRequestManagement::RequestInterview', optional: true
    belongs_to :prompt_version, class_name: 'BxBlockChat::PromptVersion'
    has_many :chatbot_responses, dependent: :destroy

    validates :status, presence: true, inclusion: { in: ['ongoing', 'completed', 'terminated'] }

    def last_response_time
      chatbot_responses.order(created_at: :desc).pluck(:created_at).first || start_time
    end
  end
end