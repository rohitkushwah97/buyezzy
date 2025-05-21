require 'rails_helper'
require 'swagger_helper'

RSpec.describe '/help_centre/question_sub_type', :jwt do
  let(:token)   { jwt }
  let(:account) { create :email_account }
  let(:id)      { account.id }

  let!(:question_type1) { create :question_type }

  path '/help_centre/question_sub_type' do
    get 'Get list of question sub type' do
      tags 'bx_block_help_centre', 'question_sub_type', 'index'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true

      let!(:question_sub_type1) { create :question_sub_type, question_type: question_type1}

      response '200', 'List of question sub type' do
        schema '$ref' => '#/components/schemas/question_sub_type'
        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data.count).to eq 1
          expect(data.first['attributes']["id"]).to eq  question_sub_type1.id
        end
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string, example: "Invalid token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 400 }
      end

      response "401", :expired do
        let(:token) { jwt_expired }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string, example: "Invalid token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 401 }
      end
    end

    post 'Create question sub type' do
      tags 'bx_block_help_centre', 'question_sub_type', 'create'
      produces "application/json"
      consumes "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          attributes: {
            type: :object,
            properties: {
              sub_type: { type: :string, example: "Test Question Sub Type" },
              description: { type: :string, example: "Test description" },
              question_type_id: { type: :integer, example: 1 }
            }
          }
        }
      }, required: true

      let(:data) {{
        data: {
          attributes: {
            sub_type: "Test Question Sub Type",
            description: "Test description",
            question_type_id: question_type1.id
          }
        }
      }}

      response '201', 'Question sub type created' do
        schema '$ref' => '#/components/schemas/question_sub_type'
        run_test! do |response|
          expect(response.status).to eq 201
          expect(BxBlockHelpCentre::QuestionSubType.count).to eq 1
        end
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string, example: "Invalid token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 400 }
      end

      response "401", :expired do
        let(:token) { jwt_expired }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string, example: "Invalid token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 401 }
      end
    end
  end

  path '/help_centre/question_sub_type/{id}' do
    get 'Get question sub type' do
      tags 'bx_block_help_centre', 'question_sub_type', 'get'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      parameter name: :id, in: :path, type: :integer, example: 1, required: true

      let!(:question_sub_type2) { create :question_sub_type, question_type: question_type1 }
      let(:id) { question_sub_type2.id }

      response '200', 'Question sub type exist' do
        schema '$ref' => '#/components/schemas/question_sub_type'
        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data['attributes']['id']).to eq question_sub_type2.id
          expect(data['attributes']['sub_type']).to eq question_sub_type2.sub_type
          expect(data['attributes']['description']).to eq question_sub_type2.description
        end
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string, example: "Invalid token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 400 }
      end

      response "401", :expired do
        let(:token) { jwt_expired }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string, example: "Invalid token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 401 }
      end
    end

    put 'Update question sub type' do
      tags 'bx_block_help_centre', 'question_sub_type', 'get'
      produces "application/json"
      consumes "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer, example: 1, required: true
      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          attributes: {
            type: :object,
            properties: {
              sub_type: { type: :string, example: "Test Question Sub Type" },
              description: { type: :string, example: "Test description" },
              question_type_id: { type: :integer, example: 1 }
            }
          }
        }
      }, required: true

      let!(:question_sub_type3) { create :question_sub_type, question_type: question_type1 }
      let(:id) { question_sub_type3.id }
      let(:data) {{
        data: {
          attributes: {
            sub_type: "Test Question Sub Type2",
            description: "Test description2",
            question_type_id: question_type1.id
          }
        }
      }}

      response '200', 'Question sub type updated' do
        schema '$ref' => '#/components/schemas/question_sub_type'
        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data['attributes']['id']).to eq question_sub_type3.id
          expect(data['attributes']['sub_type']).to eq "Test Question Sub Type2"
          expect(data['attributes']['description']).to eq "Test description2"
        end
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string, example: "Invalid token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 400 }
      end

      response "401", :expired do
        let(:token) { jwt_expired }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string, example: "Invalid token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 401 }
      end
    end

    delete 'Delete question sub type' do
      tags 'bx_block_help_centre', 'question_sub_type', 'get'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer, example: 1, required: true

      let!(:question_sub_type4) { create :question_sub_type, question_type: question_type1 }
      let(:id) { question_sub_type4.id }

      response '200', 'Question sub type deleted' do
        schema '$ref' => '#/components/schemas/question_sub_type'
        run_test! do |response|
          expect(response.status).to eq 200

          json = JSON.parse(response.body)

          expect(json['message']).to eq "Question sub type deleted."
        end
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string, example: "Invalid token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 400 }
      end

      response "401", :expired do
        let(:token) { jwt_expired }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string, example: "Invalid token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 401 }
      end
    end
  end
end
