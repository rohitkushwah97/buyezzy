# frozen_string_literal: true

require 'rails_helper'

RSpec.describe  BxBlockChat::AccountsChatsBlock, type: :model do
  let!(:chat) { create :chat, name: "test" }
  let!(:account) { create :email_account}
  let!(:account_chat){create :account_chat,status:"muted",muted:true,account_id:account.id,chat_id:chat.id}

  describe "validations" do
    it "is not valid without a chat_id" do
      account_chat.chat_id = ""
      expect(account_chat).to_not be_valid
    end
  end

  it "accounts_chats belongs_to chat" do
    expect(account_chat.chat_id).to eq ( chat.id)
  end

  it "accounts_chats belongs_to account" do
    expect(account_chat.account_id).to eq (account.id)
  end
end