# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "bx_block_roles_permissions", :jwt do
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:token) { jwt }
  let(:attributes) { data["attributes"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  let(:model_errors) { data["attributes"]["errors"] }
  let(:model_error) { errors.first }
  let(:token) { BuilderJsonWebToken.encode(account.id, 1.day.from_now, token_type: "login") }
  let(:role) { create :role, name: 'group_admin'}
  let(:role1) { create :role, name: 'basic'}

  let(:account) { create :email_account,role_id: role.id }
  let(:account2) { create :email_account,role_id: role1.id }
  let(:account1) { create :email_account }
  let(:id) { account.id }

  let(:params) do
    {
      "account_id" => account1.id,
      "role" => role.name
    }
  end

  path "/roles_permissions/accounts/get_assigned_role/{id}" do
    get "Get Assigned Role " do
      tags "Roles"
      produces "application/json"
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: "id", in: :path, type: :integer, example: 1, required: true
      
      response "200", :success do
      schema "$ref" => "#/components/schemas/accounts"        

        before do |example|
          submit_request(example.metadata)
          assert_response_matches_metadata(example.metadata)
        end

        it "Should have status 200", :success do
          expect(response.status).to eq 200
          result = JSON.parse(response.body)
          expect(result["data"]["attributes"]["role"]).to eq("group_admin")
        end

      end

        response "400", :unauthorized do
          let(:token) { "" }
          run_test!
        end

      response "403", "Account not authorized" do
          let(:token) { BuilderJsonWebToken.encode(account2.id, 1.day.from_now, token_type: "login") }

          run_test! do |response|
            expect(json["errors"]).to eq "Account not allow to view role details"
          end
        end
        
    end

  end

  path "/roles_permissions/create" do

    post "create Role" do
      tags "roles","create"
      consumes 'application/json'
      produces 'application/json'
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties:{
        name: {type: :string, example: 'basic'}
        }
      }

      let(:params) do
    {
      "name" => "group_basic"
    }
    end
      response "201", :created, success: true do
        schema "$ref" => "#/components/schemas/accounts"
        
        run_test! do |response|
          expect(response.status).to eq 201
        end
      end

      response "422", :"role value empty" do
        let(:params) do
        {
            "name" => ""
        }
      end  
        run_test! do |response|
          expect(response.status).to eq 422
          expect(json["errors"]).to eq "Please enter role name"
        end
      end

      response "422", :"role value not exists" do
        let(:params) do
        {
            "name" => "basic123"
        }
      end  
        run_test! do |response|
          expect(response.status).to eq 422
          expect(json["errors"]["name"]).to eq ["Not valid name, please select from the list: group_admin,group_basic,admin,basic"]
        end
      end

      response "403", :"account not authorized" do
       let(:token) { BuilderJsonWebToken.encode(account2.id, 1.day.from_now, token_type: "login") }
        run_test! do |response|
          expect(response.status).to eq 403
          expect(json["errors"]).to eq "You are not authorized to create or assign a role."
        end
      end

    end
  end

  path "/roles_permissions/accounts/assign_role" do

    post "Assign Role To User" do
      tags "roles"
      consumes 'application/json'
      produces 'application/json'
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :params, in: :body, schema:{
        type: :object,
        properties:{
        account_id: {type: :integer, example: 1},
        role: {type: :string, example: 'basic'}
        }
        
      }

      
      response "200", :created, success: true do
        schema "$ref" => "#/components/schemas/accounts"
        
        run_test! do |response|
          expect(response.status).to eq 200
          expect(data["attributes"]["role"]).to eq "group_admin"
        end
      end

      response "403", :"account not authorized" do
       let(:token) { BuilderJsonWebToken.encode(account2.id, 1.day.from_now, token_type: "login") }
        run_test! do |response|
          expect(response.status).to eq 403
          expect(json["errors"]).to eq "You are not authorized to create or assign a role."
        end
      end

      response "422", :"role not exists" do
        
        let(:params) {""}

        run_test! do |response|
          expect(json["errors"]).to eq [{"params"=>"role is not provided"}]
        end
      end


      response "400", :unauthorized do
        let(:token) { '' }
        run_test!
      end
      
      response "401", :unauthorized do
        let(:token) { jwt_expired }
        run_test!
      end
    end
  end

  

end