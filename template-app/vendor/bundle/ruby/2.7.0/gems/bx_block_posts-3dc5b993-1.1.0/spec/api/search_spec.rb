require "swagger_helper"

RSpec.describe "/bx_block_posts", :jwt do
  let(:headers) { {token: token} }
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:token) { BuilderJsonWebToken.encode(account.id) }
  let(:attributes) { data["attributes"] }
  let(:json_response) { JSON.parse(attributes["settings"]) }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  let(:model_errors) { data["attributes"]["errors"] }
  let(:model_error) { errors.first }
  let(:account) { create :email_account,first_name: "first_name",last_name:"last_name",full_phone_number:"13108540002",country_code:"+1",phone_number:"13108540002",activated: true}
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }
  let(:category) { create :category }
  let(:sub_category) { create :sub_category }
  let(:post) { create :post,account: account,sub_category_id: sub_category.id,category_id: category.id}

  path "/posts/posts/search?query={query}" do
    get "search post " do
      # tags "bx_block_posts", "post", "search"
      tags "show"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required:true, example: "{{bx_blocks_api_token}}"
      parameter name: :query, in: :path, type: :string,required:true, example: "description"

      let!(:query) { "Test post description" }
      response "200", :success do
        schema "$ref" => "#/components/schemas/post_lists"
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
