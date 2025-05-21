# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/categories", :jwt do
  let(:account1) { FactoryBot.create(:email_account, first_name: "first1", last_name: "last1") }
  let(:account2) { FactoryBot.create(:email_account, first_name: "first2", last_name: "last2") }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }
  let(:sub_category) { create :sub_category }

  path "/categories/sub_categories/{id}" do
    get "get a sub category" do
      tags "show"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer, required: true, example: 1

      response "200", "get a sub category" do
        let!(:id) { sub_category.id }
        schema "$ref" => "#/components/schemas/sub_category"
        run_test!
      end

      response "404", "Sub Category with id 1 doesn't exists" do
        let!(:id) { sub_category.id + 10 }
        schema type: :object,
          properties: {
            message: {type: :string, example: "SubCategory with id 1 doesn't exists"}
          }
        run_test!
      end
    end

    put "update sub category" do
      tags "update"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer, required: true, example: 1
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          sub_category: {
            properties: {
              name: {type: :string, example: "sub_category_test"}
            }
          }
        }
      }

      response "200", "update sub category successfully" do
        let!(:id) { sub_category.id }

        let(:params) do
          {
            sub_category:
            {
              name: "sub_category_test"
            }
          }
        end
        schema "$ref" => "#/components/schemas/sub_category"
        run_test!
      end

      response "404", "SubCategory with id 1 doesn't exists" do
        let!(:id) { sub_category.id + 10 }
        let(:params) do
          {
            sub_category:
            {
              name: "test"
            }
          }
        end
        schema type: :object,
          properties: {
            message: {type: :string, example: "Sub Category with id 1 doesn't exists"}
          }
        run_test!
      end

      response "422", "name already taken" do
        let!(:sub_category2) { create :sub_category, name: "test_1" }
        let!(:id) { sub_category.id }
        let(:params) do
          {
            sub_category:
            {
              name: "test_1"
            }
          }
        end
        schema type: :object,
          properties: {
            id: {type: :string, example: "1"},
            type: {type: :string, example: "error"},
            attributes: {
              properties: {
                errors: {
                  properties: {
                    name: {
                      type: :array,
                      items: {
                        type: :string
                      },
                      example: ["has already been taken"]
                    }
                  }
                }
              }
            }
          }
        run_test!
      end
    end
  end
end
