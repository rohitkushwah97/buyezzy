# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/categories", :jwt do
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
  let!(:cta) { FactoryBot.create(:cta) }
  let!(:cta1) { FactoryBot.create(:cta, visible_on_details_page: false) }

  let(:observed_response_json) do
    {
      "data" => [
        {
          "id" => cta.id.to_s,
          "type" => "cta",
          "attributes" => {
            "id" => cta.id,
            "headline" => cta.headline,
            "description" => cta.description,
            "category" => {
              "id" => cta.category.id,
              "name" => cta.category.name,
              "identifier" => cta.category.identifier,
              "created_at" => cta.category.created_at.as_json,
              "updated_at" => cta.category.updated_at.as_json,
              "admin_user_id" => nil,
              "rank" => cta.category.rank,
              "light_icon" => {"url" => cta.category.light_icon_url},
              "light_icon_active" => {"url" => cta.category.light_icon_active_url},
              "light_icon_inactive" => {"url" => cta.category.light_icon_inactive_url},
              "dark_icon" => {"url" => cta.category.dark_icon_url},
              "dark_icon_active" => {"url" => cta.category.dark_icon_active_url},
              "dark_icon_inactive" => {"url" => cta.category.dark_icon_inactive_url}
            },
            "is_square_cta" => cta.is_square_cta,
            "is_long_rectangle_cta" => cta.is_long_rectangle_cta,
            "is_text_cta" => cta.is_text_cta,
            "is_image_cta" => cta.is_image_cta,
            "has_button" => cta.has_button,
            "button_text" => cta.button_text,
            "redirect_url" => cta.redirect_url,
            "visible_on_details_page" => cta.visible_on_details_page,
            "visible_on_home_page" => cta.visible_on_home_page,
            "text_alignment" => cta.text_alignment,
            "button_alignment" => cta.button_alignment,
            "long_background_image" => cta.long_background_image_url,
            "square_background_image" => cta.square_background_image_url,
            "created_at" => cta.created_at.as_json,
            "updated_at" => cta.updated_at.as_json
          }
        }
      ]
    }
  end

  path "/categories/cta" do
    get "get cta" do
      tags "cta"
      parameter name: "token", in: :header, type: :string, default: "{{bx_blocks_api_token}}"
      parameter name: "page", in: :query, required: false, type: :integer
      parameter name: "per_page", in: :query, required: false, type: :integer
      parameter name: "visible_on_details_page", in: :query, required: false, type: :boolean
      parameter name: "visible_on_home_page", in: :query, required: false, type: :boolean

      context "given valid params" do
        let(:per_page) { 1 }
        let(:page) { 1 }

        before do |example|
          submit_request(example.metadata)
        end

        it "request should have status code 200" do
          expect(response).to have_http_status(200)
        end

        it "request should return correct no. of exams" do
          expect(data.count).to eq(1)
        end
      end

      context "visible_on_details_page" do
        let(:visible_on_details_page) { true }
        before do |example|
          submit_request(example.metadata)
        end

        it "request should have status code 200" do
          expect(response).to have_http_status(200)
        end

        it "request should return correct no. of exams" do
          expect(data.count).to eq(1)
        end
      end

      context "visible_on_home_page" do
        let(:visible_on_home_page) { true }
        before do |example|
          submit_request(example.metadata)
        end

        it "request should have status code 200" do
          expect(response).to have_http_status(200)
        end

        it "request should return correct no. of exams" do
          expect(data.count).to eq(2)
        end
      end
    end
  end
end
