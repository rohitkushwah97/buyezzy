# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/categories", :jwt do
  let(:account1) { FactoryBot.create(:email_account, first_name: "first1", last_name: "last1") }
  let(:account2) { FactoryBot.create(:email_account, first_name: "first2", last_name: "last2") }
  let(:token) { BuilderJsonWebToken.encode(account1.id, 1.day.from_now, token_type: "login") }

  path "/categories/categories" do
    post "Create category" do
      tags "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          categories: {
            type: :array,
            items:
            {
              type: :object
            },
            example: [
              name: "category1",
              light_icon: {
                data: "http://test.com"
              },
              light_icon_active: {
                data: "http://test.com"
              },
              light_icon_inactive: {
                data: "http://test.com"
              },
              dark_icon: {
                data: "http://test.com"
              },
              dark_icon_active: {
                data: "http://test.com"
              },
              dark_icon_inactive: {
                data: "http://test.com"
              }
            ]
          }
        }
      }

      response "201", "category created successfully" do
        let(:new_category_name) { "test_category" }
        let(:new_category_name2) { "test_category2" }
        let(:encode_image) { Base64.encode64(File.binread(BxBlockCategories::Engine.root.join("./spec/support/unit/image_test_new.jpg"))) }
        let(:new_image) { "data:image/jpeg;base64, #{encode_image}" }
        let(:new_image2) { "data:image/jpeg;base64, #{encode_image}" }

        let(:params) do
          {
            categories: [
              {
                name: new_category_name,
                light_icon: {data: new_image},
                light_icon_active: {data: new_image},
                light_icon_inactive: {data: new_image},
                dark_icon: {data: new_image},
                dark_icon_active: {data: new_image},
                dark_icon_inactive: {data: new_image}
              },
              {name: new_category_name2, light_icon: {data: new_image2}}
            ]
          }
        end
        schema "$ref" => "#/components/schemas/category"
        run_test!
      end

      response "422", "name already taken" do
        let!(:category1) { create :category, name: "test_category" }
        let(:new_category_name) { "test_category" }
        let(:params) do
          {
            categories: [
              {
                name: new_category_name
              }
            ]
          }
        end
        schema type: :object,
          properties: {
            message: {
              type: :array,
              items: {
                type: :string
              },
              example: ["name can't be use test_category"]
            }
          }
        run_test!
      end
    end

    get "List all categories" do
      tags "index"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :sub_category_id, in: :query, type: :integer, example: 1, required: false
      response "200", "List categories" do
        context "List all categories" do
          let!(:category) { create :category }
          schema "$ref" => "#/components/schemas/category"
          run_test!
        end

        context "Get a category based on sub category" do
          let!(:category) { create :category }
          let!(:sub_category) { create :sub_category }
          let!(:sub_category_id) { sub_category.id }
          schema "$ref" => "#/components/schemas/category"
          run_test!
        end
      end

      response "404", "No data is present or not found" do
        before do
          ActiveRecord::Base.transaction do
            ActiveRecord::Base.connection.execute("DELETE FROM categories_sub_categories")
            BxBlockCategories::SubCategory.delete_all
            BxBlockCategories::Category.delete_all
          end
        end

        context "No data is present" do
          schema type: :object,
            properties: {
              message: {type: :string, example: "No data is present"}
            }
          run_test!
        end

        context "not found" do
          let!(:category) { create :category }
          let!(:sub_category) { create :sub_category }
          let!(:sub_category_id) { sub_category.id + 10 }
          schema type: :object,
            properties: {
              errors: {
                type: :array,
                items: {
                  type: :string
                },
                example: ["Record not found"]
              }
            }
          run_test!
        end
      end
    end
  end
end
