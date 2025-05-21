require "swagger_helper"

RSpec.describe "/bx_block_catalogue", :jwt do
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

  let(:account) { create :email_account }
  let(:catalogue) { create :catalogue }

  path "/catalogue/reviews" do
    post "Create a reviews" do
      # tags "bx_block_catalogue", "reviews", "create"
      tags "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required: true, example: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          catalogue_id: {type: :integer,example:1},
          rating: {type: :integer,example:5},
          comment: {type: :string,example:"Great"}
        }
      }

      let(:catalogue_id) { catalogue.id }
      let(:params) {
        {
          catalogue_id: catalogue_id,
          rating: 10,
          comment: "A comment"
        }
      }

    
      response "201", :success do
        schema "$ref" => "#/components/schemas/review"
        run_test!
      end

    end

    get "Get all reviews" do
      # tags "bx_block_catalogue", "reviews", "index"
      tags "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string,required: true,example: "{{bx_blocks_api_token}}"

      let!(:review1) { create :review }
      let!(:review2) { create :review }

      response "200", :success do
       	schema "$ref" => "#/components/schemas/review_list"
        run_test!
      end
    end
  end
end
