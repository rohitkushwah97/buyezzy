require "rails_helper"
require "swagger_helper"

RSpec.describe "/add_user", :jwt do
  let(:json) { JSON response.body }
  let(:jwt_token) { jwt }
  let!(:chat) { create :chat, name: "test" }
  let(:account) { create :email_account,first_name: "first_name",last_name:"last_name",full_phone_number:"13108540002",country_code:"+1",phone_number:"13108540002",activated: true}
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }

  path "/chat/chats/add_user" do
    post "Add users/accounts to chat" do
      # tags "bx_block_chat", "chats/add_user", "add"
      tags "add"
      consumes "application/json"
      produces "application/json"

      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          accounts_id: {
            type: :array,
            items: {
              type: :integer,
              example: [1, 3]
            }
          },
          chat_id: {type: :integer,example:1}
        },
        required: [
          "accounts_id",
          "chat_id"
        ]
      }

	 		let(:params) { {accounts_id: [account.id], chat_id: chat.id} }
	 		response "201", :success do
	      schema "$ref" => "#/components/schemas/add_user"
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
      	let(:params) { {accounts_id: [account.id+12], chat_id: chat.id} }
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
      	let(:params) { {accounts_id: [account.id], chat_id: chat.id+12} }
      	schema type: :object,properties: {
			    errors: {
			      type: :object,
			      properties: {
			        chat: {
			          type: :array,
			          items:{
			            type: :string,example:"must exist"
			          }
			        }
			      },
			    }
			  }
			  run_test!
      end
    end
  end
end