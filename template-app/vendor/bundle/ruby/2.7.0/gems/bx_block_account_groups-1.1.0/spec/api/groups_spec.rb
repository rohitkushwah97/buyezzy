require "swagger_helper"

RSpec.describe "/groups", :jwt do
  let(:headers) { {token: token} }
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:token) { BuilderJsonWebToken.encode(account.id) }
  let(:attributes) { data["attributes"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  let(:model_errors) { data["attributes"]["errors"] }
  let(:model_error) { errors.first }

  let(:role_admin) { create :role, name: "group_admin" }
  let(:role_basic) { create :role, name: "group_basic" }
  let(:account) { create :email_account, role: role_admin }
  let(:account2) { create :email_account, role: role_basic }
  let(:account3) { create :email_account, role: role_basic }

  path "/account_groups/groups" do
    post "Create a group" do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_account_groups', 'groups', 'create'
      # First authentication header
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      # Declare request parametes
      parameter name: :create_params, in: :body, schema: {
        type: :object,
        properties: {
          group: {
            type: :object,
            properties: {
              name: {type: :string},
              settings: {type: :string},
              account_ids: {type: :array, items: {type: :number}}
            }
          }
        },
        required: ['name']
      }

      let(:new_group_name) { "test_group" }
      let(:create_params) {
        {
          group: {
            name: new_group_name,
            settings: {
              setting1: "Some value",
              settings_group: [
                {stuff: "value1"},
                {stuff2: "value2"}
              ]
            },
            account_ids: [account.id, account2.id]
          }
        }
      }
      response "201", :success do
        schema type: :object, properties: {
          data: {
            type: :object,
            properties: {
              id: {type: :string},
              type: {type: :string},
              attributes: {
                type: :object,
                properties: {
                  name: {type: :string},
                  settings: {
                    type: :object,
                    properties: {
                      setting1: {type: :string},
               settings_group: {type: :array}
                  }
                  
                  },
                  accounts: {type: :array}
                }
              }
            }
          }
        }
        context 'it creates_group' do
          run_test! do |response|
          expect(response.status).to eq 201
          expect(BxBlockAccountGroups::Group.count).to eq 1
          expect(attributes["name"]).to eq new_group_name
          expect(attributes["accounts"].count).to eq 2
          expect(account.groups.count).to eq 1
          expect(account.groups.map { |group| group.id }).to include(data["id"].to_i)
          expect(account2.groups.map { |group| group.id }).to include(data["id"].to_i)
          expect(account3.groups.count).to eq 0
        end
      end
      end

      response 422, :unprocessible_entity do
        let(:new_group_name) { "" }
        let(:create_params) {
          {
            group: {
              name: new_group_name,
              settings: {
                setting1: "Some value",
                settings_group: [
                  {stuff: "value1"},
                  {stuff2: "value2"}
                ]
              },
              account_ids: []
            }
          }
        }
        context "create group with invalid params" do
          run_test!
        end
        end
    end

    get "List groups" do
      produces 'application/json'
      tags 'bx_block_account_groups', 'groups', 'index'
      # First authentication header
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true

      let(:group1) { create :group }
      let(:group2) { create :group }
      response "200", :success do
        schema "$ref" => "#/components/schemas/group"
        
        before do |example|
          group1.account_ids = [account.id, account2.id]
          group2.account_ids = [account.id, account2.id, account3.id]
        end

        context "Logged in as group admin" do
          let(:token) { BuilderJsonWebToken.encode(account.id) }
          run_test! do |response|
            expect(response.status).to eq 200
            expect(data.count).to eq 2
            expect(json["data"].map { |group| group["attributes"]["name"] }).to include(group1.name, group2.name)
          end
        end

        context "Logged in as account3" do
          let(:token) { BuilderJsonWebToken.encode(account3.id) }
          run_test! do |response|
            expect(response.status).to eq 200
            expect(data.count).to eq 1
            expect(json["data"].map { |group| group["attributes"]["name"] }).to include(group2.name)
          end
        end
      end
    end
  end

  path "/account_groups/groups/{id}" do
    get "Get a group" do
      produces 'application/json'
      tags 'bx_block_account_groups', 'groups', 'show'
      # First authentication header
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      # Declare request parametes
      parameter name: :id, in: :path, type: :integer

      let(:group1) { create :group }
      let(:group2) { create :group }
      response "200", :success do
        schema "$ref" => "#/components/schemas/group"
    
        before do |example|
          group1.account_ids = [account.id, account2.id]
          group2.account_ids = [account.id, account2.id, account3.id]
        end

        context "Logged in as group admin" do
          let(:token) { BuilderJsonWebToken.encode(account.id) }

          context "Requesting group 1" do
            let(:id) { group1.id }
            context "shows group 1" do
              run_test! do |response|
              expect(response.status).to eq 200
              expect(json["data"]["id"].to_i).to eq group1.id
            end
          end
          end

          context "Requesting group 2" do
            let(:id) { group2.id }
            context "shows group 2" do
              run_test! do |response|
              expect(response.status).to eq 200
              expect(json["data"]["id"].to_i).to eq group2.id
            end
          end
          end
        end

        context "Logged in as account3" do
          let(:token) { BuilderJsonWebToken.encode(account3.id) }
          context "Requesting group 2" do
            let(:id) { group2.id }
            context "shows group 2" do
              run_test! do |response|
          
              expect(response.status).to eq 200
              expect(json["data"]["id"].to_i).to eq group2.id
            end
          end
          end
        end
      end
      response "422", :unauthorized do
        context "shows no access message" do
          let(:token) { BuilderJsonWebToken.encode(account3.id) }
          let(:id) { group1.id }
          schema type: :object,
            properties: {
              errors: {
                type: :array,
                items: {
                  type: :object
                },
                example: [
                  "message": "You don't have access to this account group"
                ]
              }
            }
          run_test!
        end

      end
    end

    put "Update a group" do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_account_groups', 'groups', 'update'
      # First authentication header
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      # Declare request parametes
      parameter name: :id, in: :path, type: :integer
      parameter name: :update_params, in: :body, schema: {
        type: :object,
        properties: {
          group: {
            type: :object,
            properties: {
              name: {type: :string},
              settings: {type: :string},
              account_ids: {type: :array, items: {type: :number}}
            }
          }
        },
        required: ['name']
      }

      let(:group) { create :group }
      let(:id) { group.id }
      let(:updated_group_name) { "updated group" }
      let(:updated_group_settings) { JSON.generate({"data" => [1, 2, 3]}) }
      let(:update_params) {
        {
          group: {
            name: updated_group_name,
            settings: updated_group_settings,
            account_ids: [account.id, account2.id, account3.id]
          }
        }
      }

      response "422", :success do
        schema "$ref" => "#/components/schemas/group"
        
          before do
            group.account_ids = [account.id]
          end
            context "update group without name" do
                let(:token) { BuilderJsonWebToken.encode(account.id) }
                let(:id) { group.id }
                let(:updated_group_name) { "" }
                let(:updated_group_settings) { JSON.generate({"data" => [1, 2, 3]}) }
                let(:update_params) {
                  {
                    group: {
                      name: updated_group_name,
                      settings: updated_group_settings,
                      account_ids: [account.id, account2.id, account3.id]
                    }
                  }
                }
                context "failed to update group without name" do
                  run_test! do |response|
                  expect(response.status).to eq 422
                end
              end
              end
              context "Logged in as an account that does not belong to the group" do
                    let(:token) { BuilderJsonWebToken.encode(account3.id) }
                    let(:id) { group.id }
                    context "fshows no access message" do
                      run_test! do |response|
      
                      expect(response.status).to eq 422
                      expect(error).to eq({"message" => "Only account group admin has permission for this"})
                    end
                  end
                  end

      end

      response "200", :success do
        schema "$ref" => "#/components/schemas/group"
    

        before do
          group.account_ids = [account.id]
        end

        context "Logged in as group admin" do
          let(:token) { BuilderJsonWebToken.encode(account.id) }
          let(:id) { group.id }
          context "updates group successfully" do
            run_test! do |response|
            expect(account3.groups.count).to eq 1
            expect(response.status).to eq 200
            expect(attributes["name"]).to eq updated_group_name
            expect(attributes["settings"]).to eq JSON.parse(updated_group_settings)
            expect(attributes["accounts"].map { |account| account["id"] }).to(
              include(account.id, account2.id, account3.id)
            )
            expect(account3.groups.map { |group| group.id }).to include(group.id)
          end
        end
        end

      end
   
    end

    delete "Delete a group" do
      produces 'application/json'
      tags 'bx_block_account_groups', 'groups', 'destroy'
      # First authentication header
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      # Declare request parametes
      parameter name: :id, in: :path, type: :integer

      let(:group) { create :group }
      let(:id) { group.id }

      response "200", :success do
        schema type: :object, properties: {
          message: {type: :string}
        }

        before do |_|
          group.account_ids = [account.id, account2.id]
        end

        context "Logged in as group admin" do
          let(:token) { BuilderJsonWebToken.encode(account.id) }
          context "deletes the group" do
            run_test! do |response|
            expect(response.status).to eq 200
            expect(json["message"]).to eq "Group deleted successfully!"
            expect(account.groups.count).to eq 0
            expect(account2.groups.count).to eq 0
          end
        end
        end
      end

      response "422", :success do 
           context "Logged in as account3" do
              let(:token) { BuilderJsonWebToken.encode(account3.id) }
              context "shows no access message" do
                run_test! do |response|
                expect(response.status).to eq 422
                expect(error).to eq({"message" => "Only account group admin has permission for this"})
              end
            end
            end

            context "Invalid group id" do
              let(:token) { BuilderJsonWebToken.encode(account3.id) }
              let(:id) { 500000000 }
              context "shows no group exists message" do
                run_test! do |response|
                expect(response.status).to eq 422
              end
            end
            end
      end
    end
  end

  path "/account_groups/groups/{id}/add_accounts" do
    post "Add accounts to a group" do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_account_groups', 'groups', 'add_accounts'
      # First authentication header
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      # Declare request parametes
      parameter name: :id, in: :path, type: :integer
      parameter name: :new_accounts, in: :body, schema: {
        type: :object,
        properties: {
          account_ids: {type: :array, items: {type: :number}}
        },
        required: ['account_ids']
      }

      let(:group) { create :group }
      let(:id) { group.id }
      let(:new_accounts) {
        {
          account_ids: [account2.id, account3.id]
        }
      }
      response "422", :success do
        schema "$ref" => "#/components/schemas/group"

       context "No account ids provided" do
          let(:token) { BuilderJsonWebToken.encode(account.id) }
          let(:new_accounts) {
            {
              account_ids: []
            }
          }
          context "No account ids provided" do
            run_test! do |response|
            expect(response.status).to eq 422
            expect(error).to eq({"message" => "No account ids provided"})
          end
        end
        end

        context "Logged in as a basic account" do
          let(:token) { BuilderJsonWebToken.encode(account3.id) }
          context "shows no access message" do
            run_test! do |response|
            expect(response.status).to eq 422
            expect(error).to eq({"message" => "Only account group admin has permission for this"})
          end
        end
        end
      end

      response "200", :success do
        schema "$ref" => "#/components/schemas/group"

        before do
          group.account_ids = [account.id]
        end

        context "Logged in as group admin" do
          let(:token) { BuilderJsonWebToken.encode(account.id) }
          context "adds new accounts successfully" do
            run_test! do |response|
            expect(group.accounts).to include(account)
            expect(response.status).to eq 200
            expect(group.reload.accounts).to include(account, account2, account3)
          end
        end
        end

       
      end
    end
  end

  path "/account_groups/groups/{id}/remove_accounts" do
    post "Remove accounts from a group" do
      consumes 'application/json'
      produces 'application/json'
      tags 'bx_block_account_groups', 'groups', 'remove_accounts'
      # First authentication header
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      # Declare request parametes
      parameter name: :id, in: :path, type: :integer
      parameter name: :accounts_to_remove, in: :body, schema: {
        type: :object,
        properties: {
          account_ids: {type: :array, items: {type: :number}}
        },
        required: ['account_ids']
      }

      let(:group) { create :group }
      let(:id) { group.id }
      let(:accounts_to_remove) {
        {
          account_ids: [account.id, account2.id]
        }
      }

      response "422", :success do
        schema "$ref" => "#/components/schemas/group"
         context "Logged in as a basic account" do
          let(:token) { BuilderJsonWebToken.encode(account3.id) }
          context "shows no access message" do
            run_test! do |response|
            expect(response.status).to eq 422
            expect(error).to eq({"message" => "Only account group admin has permission for this"})
          end
        end
        end
      end

      response "200", :success do
        schema "$ref" => "#/components/schemas/group"

        before do
          group.account_ids = [account.id, account2.id, account3.id]
        end

        context "Logged in as group admin" do
          let(:token) { BuilderJsonWebToken.encode(account.id) }
          context "removes accounts from the group successfully" do
            run_test! do |response|
            expect(group.accounts).to include(account, account2, account3)
            expect(response.status).to eq 200
            expect(group.reload.accounts).to include(account3)
          end
        end
        end

      end
    end
  end
end
