# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/categories", :jwt do
  let(:account1) { FactoryBot.create(:email_account, first_name: "first1", last_name: "last1") }
  let(:account2) { FactoryBot.create(:email_account, first_name: "first2", last_name: "last2") }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }
  let(:sub_category1) { create :sub_category }
  let(:sub_category2) { create :sub_category }

  path "/categories/sub_categories/update_user_sub_categories" do
    put "update user sub category" do
      tags "update_user_sub_categories"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          sub_categories_ids: {
            type: :array,
            items: {
              type: :integer
            },
            example: [1, 2]
          }
        }
      }

      response "200", "update user sub category successfully" do
        let(:params) do
          {
            sub_categories_ids: [sub_category1.id, sub_category2.id]
          }
        end
        schema "$ref" => "#/components/schemas/sub_category"
        run_test!
      end

      response "404", "Sub Category ID 1 not found" do
        let(:params) do
          {
            sub_categories_ids: [sub_category1.id + 10, sub_category2.id]
          }
        end
        schema type: :object,
          properties: {
            errors: {type: :string, example: "Sub Category ID 1 not found"}
          }
        run_test!
      end
    end
  end
end
