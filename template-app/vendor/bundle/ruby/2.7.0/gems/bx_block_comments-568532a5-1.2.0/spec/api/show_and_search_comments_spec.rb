# frozen_string_literal: true
require "swagger_helper"
RSpec.describe "/bx_block_comments", :jwt do
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:token) { BuilderJsonWebToken.encode(account_id) }
  let(:attributes) { data["attributes"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  let(:model_errors) { data["attributes"]["errors"] }
  let(:model_error) { errors.first }
  let(:account) { create :email_account }
  let(:account_id) { account.id }
  let(:category) { create :category }
  let(:sub_category) { create :sub_category }
  let(:post1) {BxBlockPosts::Post.create!(account_id: account.id,category_id: category.id,description:"he",body:"hello",name: "abc")}
 
  path "/comments/comments/search" do
    get "search comment" do
      tags "bx_block_comments", "comments", "search"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :query, in: :query, type: :string
      let(:comment3) { create :comment, account: account, commentable: post1 }
      let(:query) { comment3.comment }
     	response "200", :success do
        schema "$ref" => "#/components/schemas/comments_search"
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
                token: {type: :string,example: "Invalid token"}
              },
            }
          }
        }
        run_test!
      end
    end
  end

  path "/comments/comments/{id}" do
    get "Show comment" do
      tags "bx_block_comments", "comments", "show"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :id, in: :path, type: :integer,required:true,example:1
      let(:comment3) { create :comment, account: account, commentable: post1 }
      let(:id) { comment3.id }
      response "200", :success do
        schema "$ref" => "#/components/schemas/comment_show"
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
                token: {type: :string,example: "Invalid token"}
              },
            }
          }
        }
        run_test!
      end

      response "404", :not_found do
      	let(:id) { comment3.id+12 }
        schema type: :object,properties:{
          message: {type: :string,example: "Does not exist"}
        }
        run_test!
      end
     
    end
  end
end
         
