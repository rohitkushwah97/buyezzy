require "rails_helper"
require "swagger_helper"

RSpec.describe "/leave", :jwt do
  let(:json) { JSON response.body }
  let(:jwt_token) { jwt }
  let!(:chat) { create :chat, name: "test" }
  let(:account) { create :email_account,first_name: "first_name",last_name:"last_name",full_phone_number:"13108540002",country_code:"+1",phone_number:"13108540002",activated: true}
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }

  path "/chat/chats/leave" do
    post "Leave chat" do
      # tags "bx_block_chat", "chats/leave_chat", "leave"
      tags "leave"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          chat_id: {type: :integer,example:1}
        },
        required: ["chat_id"]
      }
      let(:params) { {chat_id: chat.id} }
      

      response "200", :success do
        schema type: :object,properties:{
          data: {
            type: :object,
            properties: {
              message: {type: :string,example:"Left the chat successfully"}
            }
          }
        }
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
        let(:params) { {chat_id: chat.id+12} }
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

      response "422",:unprocessable_entity do
        let!(:account_chat){create :account_chat,status:"muted",muted:true,account_id:account.id,chat_id:chat.id}
        # let!(:chat_message) { create :chat_message, message: "test" ,account_id:account.id ,chat_id:chat.id}
        schema type: :object,properties: {
          errors: {
            type: :array,
            items:{
              type: :object,
              properties: {
                account: {
                  type: :string,example:"Add new admin before leaving this chat"
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
