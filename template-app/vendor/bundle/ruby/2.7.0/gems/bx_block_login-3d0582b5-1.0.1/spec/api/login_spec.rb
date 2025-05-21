require "swagger_helper"

RSpec.describe "/login", :jwt do
let(:account1) { FactoryBot.create(
:email_account,
first_name:"first1",
last_name:"last1",
email: "test@gmail.com",
password:"12345678",activated:true) }
let(:json)   { JSON response.body }
let(:meta)   { json['meta'] }
let(:errors) { json['errors'] }
let(:error)  { errors.first }

path "/login/login" do
    post "Create login" do
      tags "bx_block_login", "login", "create"
      consumes "application/json"
      produces "application/json"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              email: {type: :string},
              password: {type: :string}
            }
          }
        },
        required: ["email","password"]
      }
      let(:params) {
        {
          data: {
            type: "email_account",
            attributes: {
              email: account1.email,
              password: "12345678"
            }
          }
        }
      }
      response "200", "Test created successfully" do
        schema "$ref" => "#/components/schemas/email_account"
        run_test!
      end
      response "422", "Given invalid email account credentials" do
        schema "$ref" => "#/components/schemas/email_account"
        let(:password) { 'my-invalid-password' }
        let(:params) {{
        :data => {
            :type => 'email_account',
            :attributes => {
            :email => "hello@gmail.com",
            :password => password,
            },
        },
        }}
        run_test!
      end
      response "422", "Invalid entry" do
        schema "$ref" => "#/components/schemas/sms_account"
        let(:password) { 'my-invalid-password' }
        let(:params) {{
        :data => {
            :type => 'sms_account',
            :attributes => {
            :phone => "+919790918544",
            :password => password,
            },
        },
        }}
        run_test!
      end
      response "401", "given an invalid password" do
        let(:token) { BuilderJsonWebToken.encode(account2.id, 1.day.from_now, token_type: "login") }
        let(:account)  { create :email_account, :activated => true }
        let(:password) { 'my-invalid-password' }
        let(:params) {
            {
              data: {
                type: "email_account",
                attributes: {
                  email: account.email,
                  password: "12345678"
                }
              }
            }
          }
        run_test!
      end
    end
  end
end

