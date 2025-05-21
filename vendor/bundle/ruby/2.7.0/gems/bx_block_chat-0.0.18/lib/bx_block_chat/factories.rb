FactoryBot.define do
  factory :chat, class: "BxBlockChat::Chat" do
    name { "Test name" }

    chat_type { "multiple_user" }
  end

  factory :account_chat, class: "BxBlockChat::AccountsChatsBlock" do
    account
    chat
  end

  factory :chat_message, class: "BxBlockChat::ChatMessage" do
    message { "Test message" }
    account
    chat
  end
end
