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
 
  path "/comments/comments/{id}" do
    put "Update a comment" do
      tags "bx_block_comments", "comments", "update"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :id, in: :path, type: :integer,example:1,required:true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          comment: {
            type: :object,
            properties: {
              commentable_id: {type: :integer,example:1},
              commentable_type: {type: :string,example: "BxBlockPosts::Post"},
              comment: {type: :string,example: "good"}
            },
            required: ["commentable_id","commentable_type","comment"]
          }
        }
      }

      let(:comment) do
        create :comment, account: account, commentable: post1
      end

      let(:id) { comment.id }
     	let(:params) do
        {
          comment: {
            comment: "test comment",
            commentable_id: post1.id,
            commentable_type: "BxBlockPosts::Post"
          }
        }
      end

      response "200", :success do
        schema "$ref" => "#/components/schemas/comment_update"
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

      response "400", :bad_request do
        let(:params) do
          {
            comment: {
              comment: "test comment",
              commentable_id: post1.id,
              commentable_type: "dasdkz"
            }
          }
        end
        schema type: :object,properties:{
          error: {type: :string,example: "Only BxBlockComments::Comment or BxBlockPosts::Post can be used for comment type"}
        }
        run_test!
      end

      response "422", :unprocessable_entity do
      	let(:id) { comment.id+12 }
        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                message: {type: :string,example: "Comment does not exist."}
              },
            }
          }
        }
        run_test!
      end

      response "422", :unprocessable_entity do
        let(:params) do
          {
            comment: {
              commentable_id: post1.id,
              commentable_type: "BxBlockPosts::Post"
            }
          }
        end
        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                comment: {type: :string,example: "can't be blank"}
              },
            }
          }
        }
        run_test!
      end
    end

    delete "Delete a Comments" do
      tags "bx_block_comments", "comments", "delete"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :id, in: :path, type: :integer,required:true,example:1
      let(:comment1) { create :comment, account: account, commentable: post1 }
      let(:id) { comment1.id}
      response "422", :unprocessable_entity do
      	let(:id) { comment1.id+12 }
        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                message: {type: :string,example: "Comment does not exist."}
              },
            }
          }
        }
        run_test!
      end

      response "200", :success do
        schema type: :object,properties:{
          message: {type: :string,example: "Comment deleted."}
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
                token: {type: :string,example: "Invalid token"}
              },
            }
          }
        }
        run_test!
      end
    end
  end
end
