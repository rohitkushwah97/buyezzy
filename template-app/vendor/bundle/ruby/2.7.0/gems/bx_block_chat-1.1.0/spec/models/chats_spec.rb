# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockChat::Chat, type: :model do
	let!(:chat) { create :chat, name: "test" }
  let!(:account) { create :email_account}
	let!(:account_chat){create :account_chat,status:"muted",muted:true,account_id:account.id,chat_id:chat.id}
	let!(:chat_message) { create :chat_message, message: "test" ,account_id:account.id ,chat_id:chat.id}


  describe "validations" do
    it "is not valid without a name" do
      chat.name = ""
      expect(chat).to_not be_valid
    end
  end

  it "chat has_many accounts through accounts_chats" do
  	expect(chat.accounts_chats.first.account_id).to eq (account_chat.account_id)
  end

  it "chat has_many accounts_chats" do
  	expect(chat.accounts_chats.first.id).to eq ( account_chat.id)
  end

  it "chat has_many chat_message" do
  	expect(chat.messages.first.id).to eq (chat_message.id)
  end

  # it "admin_accounts" do
  # 	debugger
  # 	expect(chat.admin_accounts).to eq(account.id)
  # end

end