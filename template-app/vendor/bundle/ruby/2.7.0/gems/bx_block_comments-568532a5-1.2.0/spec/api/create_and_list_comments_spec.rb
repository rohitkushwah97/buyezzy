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
  path "/comments/comments" do
    post "Create new comment" do
      tags "bx_block_comments", "comments", "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required: true, example: "{{bx_blocks_api_token}}"
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

      let(:params) do
        {
          comment: {
            comment: "test comment",
            commentable_id: post1.id,
            commentable_type: "BxBlockPosts::Post"
          }
        }
      end

      response "201", :success do
        schema "$ref" => "#/components/schemas/comment"
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
        let(:params) do
          {
            comment: {
              comment: "test comment",
              commentable_id: post1.id+12,
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
                commentable: {type: :string,example: "must exist"}
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

    get "sql injection attack" do
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :commentable_id, in: :query, type: :string
      parameter name: :commentable_type, in: :query, type: :string
      let!(:comment1) { create :comment, account: account, commentable: post1 }
      let!(:comment2) { create :comment, account: account, commentable: post1 }
      let(:commentable_id) { post1.id }

      context 'when query is clean' do
        let(:commentable_type) { post1.class }

        response "200", :success do
          run_test! do |response|
            expect(JSON.parse(response.body)["data"]&.map { |c| c["attributes"]["comment"] }).to match_array([comment1.comment, comment2.comment])
            expect(JSON.parse(response.body)["errors"]).to be_nil
          end
        end
      end

      context 'when SQL injection is added to params' do
        let(:commentable_type) { "') or 1=1 union select null, null, null, null, email, null, null from accounts --" }

        response "200", :success do
          run_test! do |response|
            expect(JSON.parse(response.body)["data"]&.map { |c| c["attributes"]["comment"] }).to be_nil
            expect(JSON.parse(response.body)["errors"]).to eql(["message" => "No comments."])
          end
        end
      end
    end

    get "List Comments" do
      tags "bx_block_comments", "comments", "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      let!(:comment1) { create :comment, account: account, commentable: post1 }
      let!(:comment2) { create :comment, account: account, commentable: post1 }

      response "200", :success do
        schema "$ref" => "#/components/schemas/comments_list"
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
