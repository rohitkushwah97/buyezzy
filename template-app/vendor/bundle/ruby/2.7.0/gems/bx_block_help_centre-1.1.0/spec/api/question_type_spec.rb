require 'rails_helper'
require 'swagger_helper'

RSpec.describe '/help_centre/question_type', :jwt do
  let(:token)   { jwt }
  let(:account) { create :email_account }
  let(:id)      { account.id }

  path '/help_centre/question_type' do
    get 'Retrieves question type' do
      tags 'bx_block_help_centre', 'question_type', 'index'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true

      let!(:question_type1) { create :question_type }

      response '200', 'question type found' do
        schema '$ref' => '#/components/schemas/question_type'
        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data.count).to eq 1
          expect(data.first['attributes']["id"]).to eq  question_type1.id
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

    post 'Creates question type' do
      tags 'bx_block_help_centre', 'question_type', 'create'
      produces "application/json"
      consumes "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              attributes: {
                type: :object,
                properties: {
                  que_type: { type: :string, example: "Test Question Type" },
                  description: { type: :string, example: "Test description" }
                }
              }
            }
          }
        }
      }, required: true

      let(:data) {{
        data: {
          attributes: {
            que_type: "Test Question Type",
            description: "Test description"
          }
        }
      }}

      response '201', 'question type created' do
        schema '$ref' => '#/components/schemas/question_type'
        run_test! do |response|
          expect(response.status).to eq 201
          expect(BxBlockHelpCentre::QuestionType.count).to eq 1
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

  path '/help_centre/question_type/{id}' do
    get 'Retrieves question type' do
      tags 'bx_block_help_centre', 'question_type', 'show'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer, example: 1, required: true

      let!(:question_type1) { create :question_type }
      let(:id) { question_type1.id }

      response '200', 'question type found' do
        schema '$ref' => '#/components/schemas/question_type'
        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data['attributes']["id"]).to eq  question_type1.id
          expect(data['attributes']['que_type']).to eq question_type1.que_type
          expect(data['attributes']['description']).to eq question_type1.description
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

    put 'Updates question type' do
      tags 'bx_block_help_centre', 'question_type', 'update'
      produces "application/json"
      consumes "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer, example: 1, required: true
      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              attributes: {
                type: :object,
                properties: {
                  que_type: { type: :string, example: "Test Question Type" },
                  description: { type: :string, example: "Test description" }
                }
              }
            }
          }
        }
      }, required: true

      let!(:question_type2) { create :question_type }
      let(:id) { question_type2.id }
      let(:data) {{
        data: {
          attributes: {
            que_type: "Test Question Type2",
            description: "Test description2"
          }
        }
      }}

      response '200', 'question type updated' do
        schema '$ref' => '#/components/schemas/question_type'
        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data['attributes']["id"]).to eq  question_type2.id
          expect(data['attributes']['que_type']).to eq "Test Question Type2"
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

    delete 'Deletes question type' do
      tags 'bx_block_help_centre', 'question_type', 'delete'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer, example: 1, required: true

      let!(:question_type3) { create :question_type }
      let(:id) { question_type3.id }

      response '200', 'question type deleted' do
        schema '$ref' => '#/components/schemas/question_type'
        run_test! do |response|
          expect(response.status).to eq 200

          json = JSON.parse(response.body)

          expect(json['message']).to eq "Question type deleted."
        end
      end
    end
  end
end
