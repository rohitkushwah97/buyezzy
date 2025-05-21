# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockChat::ChatMessage, type: :model do
  let(:account) { create :email_account}
  let!(:chat) {create :chat,name:"test",chat_type:1 }
	let!(:chat_message) { create :chat_message, message: "test" ,account_id:account.id ,chat_id:chat.id}


  describe "validations" do
    it "is not valid without a name" do
      chat_message.message = ""
      expect(chat_message).to_not be_valid
    end
  end

  it "chat_messages belongs to chat" do
  	debugger
    expect(chat_message.chat_id).to eq (chat.id)
  end

    it "accounts belongs to chat" do
      expect(chat_message.account_id).to eq (account.id)
    end
end