require "swagger_helper"

RSpec.describe "/chat", :jwt do
  let(:endpoint) { "/chat/chats" }
  let(:headers) { {token: token} }
  let(:data) { json["data"] }
  let(:token) { jwt }
  let(:jwt_token) { jwt }
  let(:attributes) { data["attributes"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  let(:model_errors) { data["attributes"]["errors"] }
  let(:model_error) { errors.first }
  let(:account) { create :email_account,first_name: "first_name",last_name:"last_name",full_phone_number:"13108540002",country_code:"+1",phone_number:"13108540002",activated: true}
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }

  path "/chat/chats/{id}" do
    get "Show Chat" do
      # tags "bx_block_chat", "chats", "show"
      tags "show"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      parameter name: :id, in: :path, type: :integer,required: true

      let!(:chat) { create :chat, name: "test" }
      let!(:account_chat) { create :account_chat, account_id: account.id, chat_id: chat.id }
      let(:id) { chat.id }

      response "200", :success do
        schema "$ref" => "#/components/schemas/room"
        run_test!
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }
        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string,example: "Invalid token"
                }
              },
            }
          }
        }
        run_test!
      end

    put "Update Chat" do
      # tags "bx_block_chat", "chats", "update"
      tags "update"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      parameter name: :id, in: :path, type: :integer,required: true
      parameter name: :chat, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string,example: "test room update"},
        },
        required: ["name"]
      }

      let(:chat) {
        {
          name: "test"
        }
      }

      let!(:chat) { create :chat, name: "test" }
      let(:id) { chat.id }
      response "200", :success do
        schema "$ref" => "#/components/schemas/room"
        run_test!
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }
        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string,example: "Invalid token"
                }
              },
            }
          }
        }
        run_test!
      end
    end
    end

  end

  path "/chat/chats/read_messages" do
    put "Read a chat Messages" do
    	# tags "bx_block_chat", "chats", "read_messages"
      tags "read_messages"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :params1, in: :body, schema: {
        type: :object,
        properties: {
          chat_id: {type: :integer,example: 1}
        }
      }

      let(:params1) {
        {
          chat_id: chat.id
        }
      }
      let(:chat_id) { chat.id }
      let!(:chat) { create :chat, name: "test" }
      let!(:account_chat) { create :account_chat, account_id: account.id, chat_id: chat.id }
      let!(:message) { create :chat_message, message: "This is a test message", chat: chat, is_mark_read: false }

      response "200", :success do
      	schema "$ref" => "#/components/schemas/room"
        run_test!

        before do |example|
          submit_request(example.metadata)
        end

        it "Should return read message to true" do
          message.reload
          expect(message.is_mark_read).to eq(true)
        end
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }
        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string,example: "Invalid token"
                }
              },
            }
          }
        }
        run_test!
      end

      response "404", :not_found do
       	let(:params1) {
	        {
	          chat_id: chat.id+12
	        }
	      }
      	schema type: :object,properties:{
          errors: {
            type: :string,example: "Chat room is not valid or no longer exists"
          }
        }
        run_test!
      end
    end
  end

  path "/chat/chats/mychats" do
    get "Get my chats" do
      # tags "bx_block_chat", "chats", "mychats"
      tags "mychats"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required: true, example: "{{bx_blocks_api_token}}"
      parameter name: :receiver_id, in: :query, type: :integer,required:true

      let!(:chat) { create :chat, name: "test" }
      let!(:account_chat) { create :account_chat, account_id: account.id, chat_id: chat.id }
      let(:receiver_account) { create :email_account }
      let!(:account_chat1) { create :account_chat, account_id: receiver_account.id, chat_id: chat.id }
      let!(:message) { create :chat_message, message: "This is a test message", chat_id: chat.id, account: account }
      let(:receiver_id) { receiver_account.id }

      response "200", :success do
      	schema "$ref" => "#/components/schemas/mychat"
        run_test!
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }
        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string,example: "Invalid token"
                }
              },
            }
          }
        }
        run_test!
      end
     
    end
  end

  path "/chat/chats/history" do
    get "Get chat history" do
       # tags "bx_block_chat", "chats", "history"
      tags "history"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}",required:true
      parameter name: :receiver_id, in: :query, type: :integer,required:true,example:1

      let!(:chat) { create :chat, name: "test" }
      let!(:account_chat) { create :account_chat, account_id: account.id, chat_id: chat.id }
      let(:receiver_account) { create :email_account }
      let!(:account_chat1) { create :account_chat, account_id: receiver_account.id, chat_id: chat.id }
      let!(:message) { create :chat_message, message: "This is a test message", chat_id: chat.id, account: account }
      let(:receiver_id) { receiver_account.id }

      response "200", :success do
       	schema "$ref" => "#/components/schemas/hostory"
        run_test!
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }
        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string,example: "Invalid token"
                }
              },
            }
          }
        }
        run_test!
      end

      response "404",:not_found do
      	let(:receiver_id) { 212 }
      	schema type: :object,properties:{
			    errors: {
			      type: :array,
			      items: {
			        type: :string,example: "Record not found"
			      }
			    }
			  }
			  run_test!
      end
    end
  end

  path "/chat/chats/search_messages" do
    get "Search a message record" do
      # tags "bx_block_chat", "chats", "search_messages"
      tags "search_messages"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :query, in: :query, type: :integer,required:true,example:"hello"

      let(:query) { "test" }
      let(:chat) { create :chat, name: "This is a test chat", accounts: [account] }
      let(:account2) { create :email_account }
      let(:another_chat) { create :chat, name: "Testing the chat", accounts: [account2] }
      let!(:matching_message) { create :chat_message, message: "This is a test message", chat: chat }
      let!(:also_matching_message) { create :chat_message, message: "Testing the message", chat: chat }
      let!(:not_matching_message) { create :chat_message, message: "Message name", chat: chat }
      let!(:matching_from_another_chat) { create :chat_message, message: "This is a test message", chat: another_chat }

      response "200", :success do
      	schema "$ref" => "#/components/schemas/search_msg"
        run_test!
 
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }
        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string,example: "Invalid token"
                }
              },
            }
          }
        }
        run_test!
      end
    end
  end

  path "/chat/chats/search" do
    get "Search a chat group" do
       # tags "bx_block_chat", "chats", "search"
      tags "search"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}",required:true
      parameter name: :query, in: :query, type: :integer,required:true,example:"hello"

      let(:query) { "test" }
      let!(:matching_chat) { create :chat, name: "This is a test chat", accounts: [account] }
      let!(:also_matching_chat) { create :chat, name: "Testing the chat", accounts: [account] }
      let!(:not_matching_chat) { create :chat, name: "Chat name", accounts: [account] }
      let(:account2) { create :email_account }
      let!(:matching_but_belongs_to_another_user) { create :chat, name: "Testing the chat", accounts: [account2] }

      response "200", :success do
      	schema "$ref" => "#/components/schemas/group_msg"
        run_test!
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }
        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string,example: "Invalid token"
                }
              },
            }
          }
        }
        run_test!
      end
    end
  end
end
