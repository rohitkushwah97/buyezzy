require "swagger_helper"

RSpec.describe "/bx_block_like", :jwt do
  let(:json_response) { JSON.parse(response.body) }
  let(:json) { JSON response.body }
  let(:errors) { json["errors"] }
  let(:id) { @current_user.id }
  let(:token) { jwt }
  let(:headers) { {token: token} }

  let!(:category) { create(:category, name: Faker::Name.name) }

  before(:each) do
    @current_user = create(:account, activated: true)
    @post = create(:post,
      name: "test post 1",
      category: category,
      account: @current_user,
      images: [])
    @post1 = create(:post,
      name: "test post 1",
      category: category,
      account: @current_user,
      images: [])
    @profile = create(:profile,account: @current_user)
  end
  let(:params) do
    {
      data: {
        attributes: {
          likeable_id: @post.id,
          likeable_type: @post.class.name
        }
      }
    }
  end

  let(:user1) { create :email_account, activated: true }
  let(:account_id) { user1.id }
  let(:post1) { create :post, account_id: user1.id }
  let(:comment1) { create :comment, account: user1, commentable: post1 }

  path "/like/likes" do
    post "Create Likes" do
      tags "Like Blocks,create"
      consumes "application/json"
      produces "application/json"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              attributes: {
                type: :object,
                properties: {
                  likeable_id: {type: :integer, example: 1},
                  likeable_type: {type: :string, example: 'profile'}
                }
              }
            }
          }
        }
      }

      context "success with post type" do
        response "200", :success do
          schema "$ref" => "#/components/schemas/like_create"

          run_test! do |response|
            likes = BxBlockLike::Like.where(like_by_id: @current_user.id,
              likeable_id: @post.id,
              likeable_type: @post.class.name)
            expect(likes.count).to eq 1
            expect(response.status).to eq 200
            expect(response).to have_http_status :ok
          end
        end
      end

      context "success with comment type" do
        let(:params) do
          {
            data: {
              attributes:
              {
                likeable_id: comment1.id,
                likeable_type: comment1.class.name
              }
            }
          }
        end

        response "200", :success do
        schema "$ref" => "#/components/schemas/like_create"

          run_test! do |response|

            likes = BxBlockLike::Like.where(like_by_id: @current_user.id,
              likeable_id: comment1.id,
              likeable_type: comment1.class.name)

            expect(likes.count).to eq 1
            expect(response.status).to eq 200
            expect(response).to have_http_status :ok
          end
        end
      end

      context "failure" do
        let(:params) {
          {
            data: {
              attributes: {
                likeable_id: @post.id,
                likeable_type: "BxBlockPosts::Posts"
              }
            }
          }
        }

        response "422", :unprocessable_entity do
          run_test! do |response|
            expect(errors).to include "like" => "uninitialized constant BxBlockPosts::Posts"
            expect(response).to have_http_status :unprocessable_entity
          end
        end

        response "400", :unauthorized do
          let(:token) { "" }

          run_test!
        end

        response "401", :unauthorized do
          let(:token) { jwt_expired }

          run_test!
        end
      end
    end

    get "List Likes" do
      tags "List Likes"
      consumes "application/json"
      produces "application/json"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}"
      parameter name: "like_type", in: :query, type: :string, required: false, example: 'profile'

      let(:like_type) {""}
      
      response "200", :success do
        schema "$ref" => "#/components/schemas/like"
        let!(:like_post1) do
        create(:like,
          like_by_id: @current_user.id,
          likeable: @post1)
        end
        
        run_test! do |response|
          expect(json_response.count).to eq 1
          like_by_id = json_response["data"][0]["attributes"]["like_by_id"]
          expect(like_by_id).to eq @current_user.id
          expect(response).to have_http_status :ok
        end


        response "400", :unauthorized do
          schema type: :object,
          properties:{
           errors: {
            type: :array,
            items:{
              type: :object,
              properties:{
                token: {type: :string,example: "Invalid token"}
              }
            }
           } 
          }

          let(:token) { "" }

          run_test!
        end
      end

      response "200", "blank likes" do
          
        run_test!
      end

      response "200", "with like type profile" do
        schema "$ref" => "#/components/schemas/like"
        let!(:like_post1) do
        create(:like,
          like_by_id: @current_user.id,
          likeable: @profile)
        end
        let(:like_type) {"profile"}
        run_test!
      end

      response "200", "with like type post" do
        schema "$ref" => "#/components/schemas/like"
        let!(:like_post1) do
        create(:like,
          like_by_id: @current_user.id,
          likeable: @post1)
        end
        let(:like_type) {"post"}
        run_test!
      end

    end
  end

end
