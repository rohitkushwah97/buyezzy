# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/categories", :jwt do
  let(:account1) { FactoryBot.create(:email_account, first_name: "first1", last_name: "last1") }
  let(:account2) { FactoryBot.create(:email_account, first_name: "first2", last_name: "last2") }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }
  let(:category) { create :category }

  path "/categories/categories/{id}" do
    get "get a category" do
      tags "show"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer, required: true, example: 1

      response "200", "get a category" do
        let!(:id) { category.id }
        schema "$ref" => "#/components/schemas/category"
        run_test!
      end

      response "404", "Category with id 1 doesn't exists" do
        let!(:id) { category.id + 10 }
        schema type: :object,
          properties: {
            message: {type: :string, example: "Category with id 1 doesn't exists"}
          }
        run_test!
      end
    end

    put "update category" do
      tags "update"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer, required: true, example: 1
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          categories: {
            type: :object,
            properties: {
              name: {type: :string, example: "category1"},
              light_icon: {
                properties: {
                  data: {type: :string, example: "http://test.com"}
                }
              },
              light_icon_active: {
                properties: {
                  data: {type: :string, example: "http://test.com"}
                }
              },
              light_icon_inactive: {
                properties: {
                  data: {type: :string, example: "http://test.com"}
                }
              },
              dark_icon: {
                properties: {
                  data: {type: :string, example: "http://test.com"}
                }
              },
              dark_icon_active: {
                properties: {
                  data: {type: :string, example: "http://test.com"}
                }
              },
              dark_icon_inactive: {
                properties: {
                  data: {type: :string, example: "http://test.com"}
                }
              }
            }
          }
        }
      }

      response "200", "update category successfully" do
        let!(:id) { category.id }
        let(:new_category_name) { "test_category" }
        let(:encode_image) { Base64.encode64(File.binread(BxBlockCategories::Engine.root.join("./spec/support/unit/image_test_new.jpg"))) }
        let(:new_image) { "data:image/jpeg;base64, #{encode_image}" }

        let(:params) do
          {
            categories:
            {
              name: new_category_name,
              light_icon: {data: new_image},
              light_icon_active: {data: new_image},
              light_icon_inactive: {data: new_image},
              dark_icon: {data: new_image},
              dark_icon_active: {data: new_image},
              dark_icon_inactive: {data: new_image}
            }
          }
        end
        schema "$ref" => "#/components/schemas/category"
        run_test!
      end

      response "404", "Category with id 1 doesn't exists" do
        let!(:id) { category.id + 10 }
        let(:params) do
          {
            categories:
            {
              name: "test"
            }
          }
        end
        schema type: :object,
          properties: {
            message: {type: :string, example: "Category with id 1 doesn't exists"}
          }
        run_test!
      end

      response "422", "name already taken" do
        let!(:id) { category.id }
        let!(:category2) { create :category, name: "test_1" }
        let(:params) do
          {
            categories:
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
