require "swagger_helper"

RSpec.describe "/chat", :jwt do
  let(:endpoint) { "/chat/chats" }
  let(:headers) { {token: token} }
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:jwt_token) { jwt }
  let(:attributes) { data["attributes"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  let(:model_errors) { data["attributes"]["errors"] }
  let(:model_error) { errors.first }
  let(:account) { create :email_account,first_name: "first_name",last_name:"last_name",full_phone_number:"13108540002",country_code:"+1",phone_number:"13108540002",activated: true}
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }

  path "/chat/chats" do
    post "Create a chat room" do
      # tags "bx_block_chat", "chats", "create"
      tags "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      parameter name: :chat, in: :body, schema: {
        type: :object,
        properties: {
          name: {type: :string,example: "test"}
        },
        required: ["name"]
      }

      let(:chat) {
        {
          name: "test"
        }
      }

      response "201", :success do
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

      response "422", :unprocessable_entity do
        let(:chat) {
          {
            name: ""
          }
        }
        schema type: :object,properties:{
          errors: {
            type: :object,
            properties: {
              name: {
                type: :array,
                items:{
                  type: :string,example: "can't be blank"
                }
              }
            }
          }
        }
        run_test!
      end
    end

    get "List of Chats" do
      # tags "bx_block_chat", "chats", "index"
      tags "index"
      produces "application/json"
      let!(:chat) { create :chat, name: "test" }
      let!(:account_chat) { create :account_chat, account_id: account.id, chat_id: chat.id }
      let!(:chat1) { create :chat, name: "test1" }
      # let!(:account_chat2) { create :account_chat, account_id: account.id, chat_id: chat1.id }

      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true

      response "200", :success do
        schema "$ref" => "#/components/schemas/room_list"
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
