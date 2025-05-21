# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "bx_block_filter_items/filtering", :jwt, type: :request do
  let(:headers) { {token: token} }
  let(:token) { jwt }
  let(:account) { create :email_account, activated: true }
  let(:id) { account.id }
  let(:category1) { create :category }
  let(:category2) { create :category }
  let(:category3) { create :category }
  let(:category4) { create :category }

  let(:brand1) { create :brand }
  let(:brand2) { create :brand }
  let(:brand3) { create :brand }
  let(:brand4) { create :brand }

  let(:cat2) do
    create :catalogue, price: 110, category: category2, brand: brand2
  end
  let(:cat3) do
    create :catalogue, price: 130, category: category3, brand: brand3
  end
  let(:cat4) do
    create :catalogue, price: 190, category: category4, brand: brand4
  end

  let(:json_response) { JSON.parse(response.body) }
  let(:data) { json_response["data"] }
  let(:attributes) { json_response["data"]["attributes"] }
  let(:errors) { json_response["errors"] }
  let(:error) { errors.first }

  path "/filter_items/filtering" do
    get "Filter items" do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_filter_items', 'Filter Items', 'index'
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}"

      let!(:cat1) do
        create :catalogue, price: 160, category: category1, brand: brand1
      end
      response "200", :success do
        schema '$ref' => '#/components/schemas/catalogues'
        context "list filter_items" do 
          run_test! do |response|
          expect(response.status).to eq 200
          end
        end

        context 'Should have status 200 filter by catelog id ' do
          before do |example|
            example.metadata[:example_group][:operation][:parameters] += [{
              name: 'q[category_id]',
              in: :query,
              type: :string,
              required: false
            }
          ]
          end

          let(:"q[category_id]") { 1 }
          run_test! do |_respone|
            expect(response.status).to eq 200
            json_response = JSON.parse(response.body)
          end
        end

        context 'Should have status 200 filter by price id ' do
          before do |example|
            example.metadata[:example_group][:operation][:parameters] += [{
              name: 'q[price][from]',
              in: :query,
              type: :string,
              required: false
            },
            {
              name: 'q[price][to]',
              in: :query,
              type: :string,
              required: false
            }
          ]
          end

          let(:"q[price][from]") {  100 }
          let(:"q[price][to]") {  200 }
         
          run_test! do |_respone|
            expect(response.status).to eq 200
            json_response = JSON.parse(response.body)
            
          end
        end

        context 'Should have status 200 filter by tag id ' do
          before do |example|
            example.metadata[:example_group][:operation][:parameters] += [{
              name: 'q[tag_id]',
              in: :query,
              type: :string,
              required: false
            }           
          ]
          end

          let(:"q[tag_id]") { 1 }
          run_test! do |_respone|
            expect(response.status).to eq 200
            json_response = JSON.parse(response.body)
            
          end
        end

      end




    end
  end
end
