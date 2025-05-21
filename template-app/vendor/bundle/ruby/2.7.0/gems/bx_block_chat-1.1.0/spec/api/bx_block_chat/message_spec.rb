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
  let(:account1) { create :email_account }
  let!(:chat) { create :chat, name: "This is a test chat", accounts: [account, account1] }

  path "/chat/chats/{chat_id}/messages" do
    post "Send a message" do
      # tags "bx_block_chat", "chats", "messages"
      tags "messages"
      consumes 'multipart/form-data'
    	produces 'application/vnd.api+json'
      parameter name: :token, in: :header, type: :string,required: true, example: "{{bx_blocks_api_token}}"
      parameter name: :chat_id, in: :path, type: :string, required: true,example: "1"

      parameter name: 'message[attachments]',
        description: 'Whatever',
        in: :formData,
        attributes: {
          schema: {
            type: :object,
            properties: {
              file: { type: :binary },
            },
          },
        }

      parameter name: 'message[message]',
        description: 'Whatever',
        in: :formData,
        attributes: {
          schema: {
            type: :object,
            properties: {
              text: { type: :string,example:"hello"},
            },
          },
        }

   		let(:"message[attachments]") {
   		 [
          Rack::Test::UploadedFile.new(
            Rails.root.join("app", "assets", "images", "default_user.png"),
            "image/png"
          )

        ] 
      [
          Rack::Test::UploadedFile.new(
            Rails.root.join("app", "assets", "images", "default_user.png"),
            "image/png"
          )
        ] 
   		}
      let(:"message[message]") { "test message" }
      let(:chat_id) { chat.id }

      response "201", :success do
        schema "$ref" => "#/components/schemas/send_msg"
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

      response "422",:unprocessable_entity do
      	let(:"message[message]") {  }
      	schema type: :object,properties: {
			    errors: {
			      type: :object,
			      properties: {
			        message: {
			          type: :array,
			          items:{
			            type: :string,example:"can't be blank"
			          }
			        }
			      },
			    }
			  }
			  run_test!
      end

      response "404", :not_found do
        let(:chat_id) { chat.id+12 }
      	schema type: :object,properties:{
          errors: {
            type: :string,example: "Chat room is not valid or no longer exists"
          }
        }
        run_test!
      end
    end
  end
end
