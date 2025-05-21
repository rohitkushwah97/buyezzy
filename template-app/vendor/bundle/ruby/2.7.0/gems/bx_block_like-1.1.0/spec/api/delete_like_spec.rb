require "swagger_helper"

RSpec.describe "/bx_block_like", :jwt do
  let(:json_response) { JSON.parse(response.body) }
  let(:json) { JSON response.body }
  let(:errors) { json["errors"] }
  let(:id) { @current_user.id }
  let(:token) { jwt }
  let(:headers) { {token: token} }

  let!(:category) {
    BxBlockCategories::Category.create!(name: Faker::Name.name)
  }

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

  
  path "/like/likes/{like_id}" do
    delete "Delete a Like" do
      tags "Like Blocks,delete"
      consumes "application/json"
      produces "application/json"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}"
      parameter name: :like_id, in: :path, type: :integer, example: 1

      let(:like_post1) {
        create(:like,
          like_by_id: @current_user.id,
          likeable_id: @post1.id,
          likeable_type: @post1.class.name)
      }

      context "given a valid comment id" do
        let(:like_id) { like_post1.id }

        response "200", :success do
          schema type: :object,
            properties: {
              message: {type: :string,example: "Successfully destroy"}
            }
          run_test! do |response|
            expect(json["message"]).to eq "Successfully destroy"
            expect(response).to have_http_status :ok
          end
        end
      end

      context "given an invalid like id" do
        let(:like_id) { like_post1.id + 100 }

        response "404", :not_found do
          schema type: :object,
            properties: {
              message: {type: :string,example: "Not found"}
            }

          run_test! do |response|
            expect(json_response["message"]).to eq "Not found"
            expect(response).to have_http_status :not_found
          end
        end
      end
    end
  end

end