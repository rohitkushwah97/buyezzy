# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/categories", :jwt do
  let(:account1) { FactoryBot.create(:email_account, first_name: "first1", last_name: "last1") }
  let(:account2) { FactoryBot.create(:email_account, first_name: "first2", last_name: "last2") }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }
  let(:category1) { create :category }
  let(:category2) { create :category }

  path "/categories/categories/update_user_categories" do
    put "update user category" do
      tags "update_user_categories"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          categories_ids: {
            type: :array,
            items: {
              type: :integer
            },
            example: [1, 2]
          }
        }
      }

      response "200", "update user category successfully" do
        let(:params) do
          {
            categories_ids: [category1.id, category2.id]
          }
        end
        schema "$ref" => "#/components/schemas/category"
        run_test!
      end

      response "422", "Category ID 1 not found" do
        let(:params) do
          {
            categories_ids: [category1.id + 10, category2.id]
          }
        end
        schema type: :object,
          properties: {
            errors: {type: :string, example: "Category ID 1 not found"}
          }
        run_test!
      end
    end
  end
end
