require "swagger_helper"

RSpec.describe "/bx_block_subscription_billing", :jwt do
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:token) { jwt }
  let(:attributes) { data["attributes"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  let(:model_errors) { data["attributes"]["errors"] }
  let(:model_error) { errors.first }
  let(:token) { BuilderJsonWebToken.encode(account.id) }

  let(:account) { create :email_account }
  let(:id) { account.id }
  let(:recurring_subscription) { FactoryBot.create(:recurring_subscription) }

  let(:recurring_subscription_params) do
    {
      "name" => Faker::Name.unique.name,
      "fee" => Faker::Number.positive.to_s,
      "billing_date" => Faker::Date.between(from: "2022-01-01", to: "2100-01-01"),
      "billing_frequency" => "monthly"
    }
  end

  let(:update_params) do
    {
      "fee" => Faker::Number.positive.to_s,
      "billing_frequency" => "monthly"
    }
  end

  path "/subscription_billing/recurring_subscriptions" do
    post "Create Recurring Subscription" do
      tags "Subsciption Billing"
      consumes "application/json"
      produces "application/json"
      parameter name: "token", in: :header, type: :string, default: "{{bx_blocks_api_token}}"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          id: {type: :integer},
          name: {type: :string},
          fee: {type: :integer},
          billing_date: {type: :date},
          billing_frequency: {type: :integer}
        }
      }

      let(:params) { recurring_subscription_params }
      response "201", :success do
        schema type: :object,
          properties: {
            id: {type: :integer},
            name: {type: :string},
            fee: {type: :string},
            billing_date: {type: :date},
            billing_frequency: {type: :integer},
            created_at: {type: :datetime},
            updated_at: {type: :datetime}
          }

        before do |example|
          submit_request(example.metadata)
        end

        it "Should have status 201" do
          expect(response.status).to eq 201
        end

        it "Should have same response description" do
          json_response = JSON.parse(response.body)
          expect(json_response["billing_frequency"]).to eq recurring_subscription.billing_frequency
        end
      end

      response "400", :unauthorized do
        let(:token) { "" }

        run_test!
      end

      response "401", :unauthorized do
        let(:token) { jwt_expired }

        run_test!
      end
    end

    get "List of Recurring Subscriptions " do
      tags "Subsciption Billing"
      parameter name: "token", in: :header, type: :string, default: "{{bx_blocks_api_token}}"
      let!(:recurring_subscription) { FactoryBot.create(:recurring_subscription) }

      response "201", :success do
        before do |example|
          submit_request(example.metadata)
        end

        it "Should have status 200" do
          expect(response.status).to eq 200
        end

        it "Should have same response " do
          json_response = JSON.parse(response.body)
          expect(json_response["data"][0]["attributes"]["billing_frequency"]).to eq recurring_subscription.billing_frequency
        end
      end
    end
  end

  path "/subscription_billing/recurring_subscriptions/{id}" do
    delete "Delete a Recurring Subscription" do
      tags "Subsciption Billing"
      parameter name: "token", in: :header, type: :string, default: "{{bx_blocks_api_token}}"
      parameter name: :id, in: :path, type: :integer

      let!(:recurring_subscription) { FactoryBot.create(:recurring_subscription, account_id: account.id) }
      let(:id) { recurring_subscription.id }

      response "200", :success do
        schema type: :object,
          properties: {
            message: {type: :string}
          }

        before do |example|
          submit_request(example.metadata)
        end

        it "Should have status 200" do
          expect(response.status).to eq 200
        end

        it "Should have same reponse" do
          json_response = JSON.parse(response.body)
          expect(json_response["message"]).to eq("Subscription Billing removed")
        end
      end
    end
    patch "Update a Recurring Subscription" do
      tags "Subsciption Billing"
      consumes "application/json"
      produces "application/json"
      parameter name: "token", in: :header, type: :string, default: "{{bx_blocks_api_token}}"
      parameter name: :id, in: :path, type: :integer
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          fee: {type: :string},
          billing_frequency: {type: :integer}
        }
      }

      let!(:recurring_subscription) { FactoryBot.create(:recurring_subscription, account_id: account.id) }
      let(:id) { recurring_subscription.id }

      let(:params) { update_params }

      response "200", :success do
        schema type: :object,
          properties: {
            id: {type: :integer},
            name: {type: :string},
            fee: {type: :string},
            billing_date: {type: :date},
            billing_frequency: {type: :integer},
            created_at: {type: :datetime},
            updated_at: {type: :datetime}
          }
        before do |example|
          submit_request(example.metadata)
        end

        it "Should have status 200" do
          expect(response.status).to eq 200
        end

        it "Should have same reponse" do
          json_response = JSON.parse(response.body)
          expect(json_response["billing_frequency"]).to eq recurring_subscription.billing_frequency
        end
      end
    end
  end
end
