# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/categories", :jwt do
  let(:account1) { FactoryBot.create(:email_account, first_name: "first1", last_name: "last1") }
  let(:account2) { FactoryBot.create(:email_account, first_name: "first2", last_name: "last2") }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }
  let(:category1) { create :category }

  path "/categories/sub_categories" do
    post "Create sub category" do
      tags "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          sub_category: {
            properties: {
              name: {type: :string, example: "sub_category_test"}
            }
          },
          parent_categories: {
            type: :array,
            items: {
              type: :integer
            },
            example: [1, 2]
          }
        }
      }

      response "201", "sub category created successfully" do
        let(:params) do
          {
            sub_category: {
              name: "sub_category"
            },
            parent_categories: [category1.id]
          }
        end
        schema "$ref" => "#/components/schemas/sub_category"
        run_test!
      end

      response "422", "name already taken" do
        let!(:sub_category2) { create :sub_category, name: "test_1" }
        let(:params) do
          {
            sub_category:
            {
              name: "test_1"
            },
            parent_categories: [category1.id]
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

      response "404", "Category ID not found" do
        let(:params) do
          {
            sub_category: {
              name: "sub_category_test"
            },
            parent_categories: [category1.id + 10]
          }
        end
        schema type: :object,
          properties: {
            errors: {type: :string, example: "Category ID 1 not found"}
          }
        run_test!
      end
    end

    get "List all sub categories" do
      tags "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :category_id, in: :query, type: :integer, example: 1, required: false

      response "200", "List all sub categories" do
        context "List all categories" do
          let!(:sub_category1) { create :sub_category }
          schema "$ref" => "#/components/schemas/sub_category"
          run_test!
        end

        context "Get a sub category" do
          let!(:category) { create :category }
          let!(:sub_category) { create :sub_category }
          let!(:category_id) { category.id }
          schema "$ref" => "#/components/schemas/sub_category"
          run_test!
        end
      end

      response "404", "No data is present" do
        before do
          ActiveRecord::Base.transaction do
            ActiveRecord::Base.connection.execute("DELETE FROM categories_sub_categories")
            BxBlockCategories::SubCategory.delete_all
            BxBlockCategories::Category.delete_all
          end
        end

        schema type: :object,
          properties: {
            message: {type: :string, example: "No data is present"}
          }
        run_test!
      end
    end
  end
end
