require_relative '../swagger_helper'

RSpec.describe "/account", :jwt do
  let(:json) { JSON response.body }
  let(:data) { json["data"] }
  let(:errors) { json["errors"] }
  let(:error) { errors.first }
  
  path "/account/accounts" do
    post "Create a account" do
      tags "bx_block_Account", "Account", "create"
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
              email: email,
              password: "password"
            }
          }
        }
      }

      let(:invalid_account_params) {
        {
          data: {
            type: "test_account",
            attributes: {
              email: email,
              password: "password"
            }
          }
        }
      }

      let(:email) { "email@acme.com" }

      let(:account) { AccountBlock::Account.first }
      let(:token) { BuilderJsonWebToken.decode json["meta"]["token"] }

      context "given a valid email" do
        response "201", :success do
          schema "$ref" => "#/components/schemas/email_account"
          schema type: :object, properties: {
            data: {
              type: :object,
              properties: {
                id: {type: :string},
                type: {type: :string},
                attributes: {
                  type: :object,
                  properties: {
                    first_name: {type: :string},
                    last_name: {type: :string},
                    email: {type: :string},
                    activated: {type: :boolean}
                  }
                }
              }
            }
          }
        end

        before do |example|
          AccountBlock::Account.delete_all
          submit_request(example.metadata)
        end

        it "creates an email account and returns a valid token" do
          expect(response.status).to eq 201
          expect(AccountBlock::Account.count).to eq 1
          expect(data["id"].to_i).to eq account.id
          expect(token.id).to eq account.id
          expect(account.unique_auth_id).not_to be_nil
        end
      end

      context "given an invalid email" do
        response "422", :unprocessable_entity do
          schema "$ref" => "#/components/schemas/email_account"
          let(:account) { AccountBlock::Account.first }
          let(:token) { BuilderJsonWebToken.decode json["meta"]["token"] }
          let(:email) { "email@acme" }

          before do |example|
            submit_request(example.metadata)
          end

          it "returns a 422" do
            expect(response.status).to eq 422
            expect(json["errors"].count).to be > 0
          end
        end
      end

      context "given an invalid account" do
        response "422", :unprocessable_entity do
          schema "$ref" => "#/components/schemas/email_account"
          # let(:account) { AccountBlock::Account.first }
          # let(:token) { BuilderJsonWebToken.decode json["meta"]["token"] }
          # let(:email) { "email@acme" }
          let(:params) {
            {
              data: {
                type: "test_account",
                attributes: {
                  email: email,
                  password: "password"
                }
              }
            }
          }

          before do |example|
            submit_request(example.metadata)
          end

          it "returns a 422" do
            expect(response.status).to eq 422
            expect(json["errors"].count).to be > 0
          end
        end
      end

      context "given an existing email" do
        response "422", :unprocessable_entity do
          schema "$ref" => "#/components/schemas/email_account"
          let(:account) { create :email_account }
          let(:email) { account.email }

          before do |example|
            submit_request(example.metadata)
          end

          it "returns a 422" do
            expect(response.status).to eq 422
            expect(json["errors"].count).to be > 0
          end
        end
      end

      context "given an existing email provided in different case" do
        response "422", :unprocessable_entity do
          schema "$ref" => "#/components/schemas/email_account"
          let!(:account) { create :email_account, email: "mYeMaIl@gMaIl.cOm" }
          let(:email) { "MyEmAil@GmAiL.CoM" }

          before do |example|
            submit_request(example.metadata)
          end

          it "returns a 422" do
            expect(response.status).to eq 422
            expect(json["errors"].count).to be > 0
          end
        end
      end
    end

    get "Get all accounts" do
      tags "bx_block_Account", "Account", "index"
      produces "application/json"
      let!(:account1) { create :email_account }
      let!(:account2) { create :email_account }

      context "given valid parameters" do
        response "201", :success do
          schema "$ref" => "#/components/schemas/email_account"
          schema type: :object, properties: {
            data: {
              type: :object,
              properties: {
                id: {type: :string},
                type: {type: :string},
                attributes: {
                  type: :object,
                  properties: {
                    first_name: {type: :string},
                    last_name: {type: :string},
                    email: {type: :string},
                    activated: {type: :boolean}
                  }
                }
              }
            }
          }
        end

        before do |example|
          AccountBlock::Account.where.not(id: [account1.id, account2.id]).delete_all
          submit_request(example.metadata)
        end

        it "Get all accounts" do
          expect(response.status).to eq 200
          expect(AccountBlock::Account.count).to eq 2
        end
      end
    end
  end

  path "/account/accounts/country_code_and_flag" do
    get "country_code_and_flag" do
      tags "bx_block_Account", "Account", "index"
      produces "application/json"
      response "200", :success do
        schema "$ref" => "#/components/schemas/email_account"
        context "returns country_code_and_flag" do
          let(:bermuda) { data.find { |el| el["id"] == "BM" } }
          let(:heard_island) { data.find { |el| el["id"] == "HM" } }
          let(:us) { data.find { |el| el["id"] == "US" } }

          before do |example|
            submit_request(example.metadata)
          end

          it "returns expected country codes" do
            expect(response.status).to eq 200
            expect(us["attributes"]["country_code"].to_i).to eq 1 # country_code
            expect(bermuda["attributes"]["country_code"].to_i).to eq 1441 # nanp
            expect(heard_island["attributes"]["country_code"].to_i).to eq 672 # custom
          end
        end
      end
    end
  end

  path "/account/accounts/email_confirmation" do
    get "email_confirmation" do
      tags "bx_block_Account", "Account", "index"
      produces "application/json"
      let(:account) { create :email_account }
      let(:id) { account.id }

      parameter name: "token", in: :query, type: :string
      context "given an email account that has not been activated" do
        response "200", :success do
          schema "$ref" => "#/components/schemas/email_account"
          let(:token) { jwt }
          before do |example|
            submit_request(example.metadata)
          end

          it "activates an existing email account" do
            expect(response.status).to eq 200
            expect(data["attributes"]["activated"]).to eq true
          end
        end

        context "given an expired token" do
          response "401", :unauthorized do
            schema "$ref" => "#/components/schemas/email_account"
            let(:token) { jwt_expired }

            before do |example|
              submit_request(example.metadata)
            end

            it "indicates that the token is expired" do
              expect(response.status).to eq 401
              expect(error["token"]).to match(/expired/i)
            end
          end
        end

        context "given an invalid token" do
          response "400", :bad_request do
            schema "$ref" => "#/components/schemas/email_account"
            let(:token) { "invalid-token" }

            before do |example|
              submit_request(example.metadata)
            end

            it "indicates that the token is invalid" do
              expect(response.status).to eq 400
              expect(error["token"]).to match(/invalid/i)
            end
          end
        end
      end

      context "given an email account that has been activated" do
        let(:account) { create :email_account, activated: true }
        let(:id) { account.id }
        let(:token) { jwt }

        response "400", :bad_request do
          schema "$ref" => "#/components/schemas/email_account"
          before do |example|
            submit_request(example.metadata)
          end

          it "does nothing" do
            expect(response.status).to eq 200
            expect(data["attributes"]["activated"]).to eq true
          end
        end
      end

      context "given an sms account" do
        let(:account) { create :sms_account }
        let(:token) { jwt }

        response "422", :unprocessable_entity do
          before do |example|
            submit_request(example.metadata)
          end

          it "indicates that the action could not be performed" do
            expect(response.status).to eq 422
            expect(errors.count).to be > 0
          end
        end
      end

      context "given the account does not exist" do
        let(:id) { 0 }
        let(:token) { jwt }

        response "422", :unprocessable_entity do
          before do |example|
            submit_request(example.metadata)
          end

          it "indicates that the account could not be activated" do
            expect(response.status).to eq 422
            expect(error["account"]).to match(/not found/i)
          end
        end
      end
    end
  end

  path "/account/accounts/sms_confirmation" do
    post "sms_confirmation" do
      tags "bx_block_Account", "Account", "create"
      consumes "application/json"
      produces "application/json"
      let(:sms_otp) { create :sms_otp }
      let(:pin) { sms_otp.pin }
      let(:id) { sms_otp.id }
      let(:params) { {pin: pin} }

      parameter name: "token", in: :query, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          pin: {type: :string}
        },
        required: ["email","password"]
      }

      context "given an sms otp that has not been activated" do
        response "200", :success do
          let(:token) { jwt }
          before do |example|
            submit_request(example.metadata)
          end

          it "activates an existing sms account" do
            expect(response.status).to eq 200
            expect(data["attributes"]["activated"]).to eq true
          end
        end

        context "given an expired otp record" do
          response "401", :unauthorized do
            let(:token) { jwt }
            before { sms_otp.update valid_until: 1.minute.ago }

            before do |example|
              submit_request(example.metadata)
            end
            it "indicates that the pin is expired" do
              expect(response.status).to eq 401
              expect(error["pin"]).to match(/expired/i)
            end
          end
        end

        context "given an incorrect pin" do
          let(:pin) { sms_otp.pin.to_s + "-invalid" }
          let(:token) { jwt }
          response "422", :unprocessable_entity do
            before do |example|
              submit_request(example.metadata)
            end

            it "indicates that the pin is invalid" do
              expect(response.status).to eq 422
              expect(error["pin"]).to match(/invalid/i)
            end
          end
        end
      end

      context "given an sms otp that has been activated" do
        let(:sms_otp) { create :sms_otp, activated: true }
        let(:token) { jwt }

        response "200", :success do
          before do |example|
            submit_request(example.metadata)
          end

          it "does nothing" do
            expect(response.status).to eq 200
            expect(data["attributes"]["activated"]).to eq true
          end
        end
      end

      context "given the sms otp record does not exist" do
        let(:id) { -1 }
        let(:token) { jwt }

        response "422", :unprocessable_entity do
          before do |example|
            submit_request(example.metadata)
          end

          it "indicates that the token is invalid" do
            expect(response.status).to eq 422
            expect(error["phone"]).to match(/not found/i)
          end
        end
      end
    end
  end

  path "/account/accounts/send_otp" do
    post "send_otp" do
      tags "bx_block_Account", "Account", "create"
      consumes "application/json"
      produces "application/json"
      let(:account) { create :sms_account, activated: activated }
      let(:activated) { false }
      let(:phone_number) { generate :phone_number }

      let(:params) {
        {
          data: {
            attributes: {
              full_phone_number: phone_number
            }
          }
        }
      }

      before do
        allow(Rails.configuration.x.sms).to receive(:provider).and_return(:test)
        allow(Rails.configuration.x.sms).to receive(:from).and_return("TEST-FROM")
        BxBlockSms::Providers::Test.clear_messages
      end

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              full_phone_number: {type: :string}
            }
          }
        },
        required: ["email","password"]
      }
      context "given no account" do
        context "given a valid phone number" do
          let(:id) { data["id"].to_i }
          let(:sms_otp) { AccountBlock::SmsOtp.find id }

          response "201", :success do
            # schema "$ref" => "#/components/schemas/email_account"
            schema type: :object, properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string},
                  type: {type: :string}
                }
              }
            }

            before do |example|
              submit_request(example.metadata)
            end

            it "creates an sms otp record" do
              expect(response.status).to eq 201
              expect(AccountBlock::SmsOtp.order(id: :asc).last).to eq(sms_otp)
            end

            it "sends a SMS with the pin" do
              expect(BxBlockSms::Providers::Test.messages)
                .to eq([{
                  from: "TEST-FROM",
                  to: "+#{Phonelib.parse(phone_number).sanitized}",
                  content: "Your Pin Number is #{sms_otp.pin}"
                }])
            end
          end
        end
      end

      context "given an sms account" do
        let(:phone_number) { account.full_phone_number }

        let(:id) { data["id"].to_i }
        let(:sms_otp) { AccountBlock::SmsOtp.find id }

        context "given the account has not been activated" do
          response "201", :success do
            schema "$ref" => "#/components/schemas/email_account"
            schema type: :object, properties: {
              data: {
                type: :object,
                properties: {
                  id: {type: :string},
                  type: {type: :string}
                }
              }
            }

            before do |example|
              submit_request(example.metadata)
            end

            it "creates an sms otp record" do
              expect(response.status).to eq 201
              expect(AccountBlock::SmsOtp.order(id: :asc).last).to eq(sms_otp)
            end

            it "sends a SMS with the pin" do
              expect(BxBlockSms::Providers::Test.messages)
                .to eq([{
                  from: "TEST-FROM",
                  to: "+#{Phonelib.parse(phone_number).sanitized}",
                  content: "Your Pin Number is #{sms_otp.pin}"
                }])
            end
          end
        end

        context "given the account has been activated" do
          let(:activated) { true }
          response "422", :unprocessable_entity do
            before do |example|
              submit_request(example.metadata)
            end

            it "indicates that the account has already been activated" do
              expect(response.status).to eq 422
              expect(error["account"]).to match(/already activated/i)
            end
          end
        end
      end

      context "given an invalid phone number" do
        let(:phone_number) { "invalid-number" }

        response "422", :unprocessable_entity do
          before do |example|
            submit_request(example.metadata)
          end

          it "indicates that the phone number is invalid" do
            expect(response.status).to eq 422
            expect(error["full_phone_number"]).to match(/invalid/i)
          end
        end
      end
    end
  end

  path "/account/accounts/change_email_address" do
    put "change email address" do
      tags "bx_block_Account", "Account", "update"
      consumes "application/json"
      produces "application/json"
      let(:id) { account.id }
      let(:account) { create :email_account }
      let(:token) { BuilderJsonWebToken.encode(account.id) }
      let(:email) { "user2@gmail.com" }
      let(:params) { {email: email} }

      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}"
      parameter name: "params", in: :body, schema: {
        type: :object,
        properties: {
          email: {type: :string}
        }
      }

      context "given valid parameters" do
        response "200", :success do
          schema "$ref" => "#/components/schemas/email_account"
          schema type: :object, properties: {
            data: {
              type: :object,
              properties: {
                id: {type: :string},
                type: {type: :string},
                attributes: {
                  type: :object,
                  properties: {
                    first_name: {type: :string},
                    last_name: {type: :string},
                    email: {type: :string},
                    activated: {type: :boolean}
                  }
                }
              }
            }
          }
        end

        before do |example|
          submit_request(example.metadata)
        end

        it "change email address" do
          expect(response.status).to eq 200
          expect(json["data"]["attributes"]["email"]).to eq email
        end
      end

      context "given an expired token" do
        let(:token) { jwt_expired }

        response "401", :unauthorized do
          before do |example|
            submit_request(example.metadata)
          end

          it "indicates that the token has expired" do
            expect(response.status).to eq 401
            expect(error["token"]).to match(/expired/i)
          end
        end
      end

      context "given an invalid token" do
        let(:token) { "invalid_token" }

        response "400", :bad_request do
          before do |example|
            submit_request(example.metadata)
          end

          it "indicates that the record was not found" do
            expect(response.status).to eq 400
            expect(error).to match({"token" => "Invalid token"})
          end
        end
      end
      context "given an invalid email" do
        let(:email) { "phonetestnumber" }
        let(:params) { {email: email} }

        response "402", :unauthorized do
          before do |example|
            submit_request(example.metadata)
          end

          it "indicates that the invalid number" do
           
            expect(response.status).to eq 422
            # expect(error["email"]).to match(/Email invalid/i)
          end
        end
      end
      context "given an existing email" do
        response "422", :unprocessable_entity do
          let(:account) { create :email_account }
          let(:email) { account.email }
          before do |example|
            submit_request(example.metadata)
          end
          it "returns a 422" do
            expect(response.status).to eq 422
            expect(json["errors"]).to match(/Entered email already exist with account please add another email/i)    
          end
        end
      end
    end
  end
  path "/account/accounts/change_phone_number" do
    put "change phone number" do
      tags "bx_block_Account", "Account", "update"
      consumes "application/json"
      produces "application/json"
      let(:id) { account.id }
      let(:account) { create :email_account }
      let(:token) { BuilderJsonWebToken.encode(account.id) }
      let(:phone_number) { "+911234567890" }
      let(:params) { {full_phone_number: phone_number} }

      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}"
      parameter name: "params", in: :body, schema: {
        type: :object,
        properties: {
          full_phone_number: {type: :string}
        }
      }

      context "given valid parameters" do
        response "200", :success do
          schema "$ref" => "#/components/schemas/email_account"
          schema type: :object, properties: {
            data: {
              type: :object,
              properties: {
                id: {type: :string},
                type: {type: :string},
                attributes: {
                  type: :object,
                  properties: {
                    first_name: {type: :string},
                    last_name: {type: :string},
                    email: {type: :string},
                    activated: {type: :boolean}
                  }
                }
              }
            }
          }
        end

        before do |example|
          submit_request(example.metadata)
        end

        it "change phone number" do
          expect(response.status).to eq 200
          expect(json["data"]["attributes"]["phone_number"]).to eq "1234567890"
        end
      end

      context "given an expired token" do
        let(:token) { jwt_expired }

        response "401", :unauthorized do
          before do |example|
            submit_request(example.metadata)
          end

          it "indicates that the token has expired" do
            expect(response.status).to eq 401
            expect(error["token"]).to match(/expired/i)
          end
        end
      end

      context "given an invalid number" do
        let(:phone_number) { "phonetestnumber" }
        let(:params) { {full_phone_number: phone_number} }

        response "401", :unauthorized do
          before do |example|
            submit_request(example.metadata)
          end

          it "indicates that the invalid number" do
            expect(response.status).to eq 422
          end
        end
      end

      context "given an invalid token" do
        let(:token) { "invalid_token" }

        response "400", :bad_request do
          before do |example|
            submit_request(example.metadata)
          end

          it "indicates that the record was not found" do
            expect(response.status).to eq 400
            expect(error).to match({"token" => "Invalid token"})
          end
        end
      end
    end
  end
  path "/account/accounts/logged_user" do
    get "logged_user" do
      tags "bx_block_Account", "Account", "index"
      produces "application/json"
      let(:id) { account.id }
      let(:account) { create :email_account }
      let(:token) { BuilderJsonWebToken.encode(account.id) }
      parameter name: "token", in: :header, type: :string, example: "{{bx_blocks_api_token}}"
      context "given valid parameters" do
        response "200", :success do
          schema "$ref" => "#/components/schemas/email_account"
          schema type: :object, properties: {
            data: {
              type: :object,
              properties: {
                id: {type: :string},
                type: {type: :string},
                attributes: {
                  type: :object,
                  properties: {
                    first_name: {type: :string},
                    last_name: {type: :string},
                    email: {type: :string},
                    activated: {type: :boolean}
                  }
                }
              }
            }
          }
        end
        before do |example|
          AccountBlock::Account.delete_all
          submit_request(example.metadata)
        end
        it "change phone number" do
          expect(response.status).to eq 200
          expect(AccountBlock::Account.count).to eq 1
          expect(data["id"].to_i).to eq account.id
        end
      end
      context "given an expired token" do
        let(:token) { jwt_expired }

        response "401", :unauthorized do
          before do |example|
            submit_request(example.metadata)
          end

          it "indicates that the token has expired" do
            expect(response.status).to eq 401
            expect(error["token"]).to match(/expired/i)
          end
        end
      end
    end
  end
end
