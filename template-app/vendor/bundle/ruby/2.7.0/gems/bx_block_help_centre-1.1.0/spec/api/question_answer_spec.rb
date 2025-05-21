require 'rails_helper'
require 'swagger_helper'

RSpec.describe '/help_centre/question_answer', :jwt do
  let(:token)   { jwt }
  let(:account) { create :email_account }
  let(:id)      { account.id }

  let!(:question_sub_type1) { create :question_sub_type }

  path '/help_centre/question_answer' do
    get 'Get a list of question answer' do
      tags 'bx_block_help_centre', 'question_answer', 'index'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true

      let!(:question_answer1) { create :question_answer, question_sub_type: question_sub_type1 }

      response '200', :success do
        schema '$ref' => '#/components/schemas/question_answer'
        run_test! { |response| expect(response.status).to eq 200 }
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

    post 'Create a question answer' do
      tags 'bx_block_help_centre', 'question_answer', 'create'
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}",required: true
      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          attributes: {
            type: :object,
            properties: {
              question: { type: :string, example: "Test Question 1" },
              answer: { type: :string, example: "Test Answer 1" },
              question_sub_type_id: { type: :integer, example: 1 }
            }
          }
        }
      }, required: true

      let(:data) {{
        data: {
          attributes: {
            question: "Test Question 1",
            answer: "Test Answer 1",
            question_sub_type_id: question_sub_type1.id
          }
        }
      }}

      response '201', :success do
        schema '$ref' => '#/components/schemas/question_answer'
        run_test! do |response|
          expect(response.status).to eq 201
          expect(BxBlockHelpCentre::QuestionAnswer.count).to eq 1
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
                  type: :string, example: "Expired token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 401 }
      end
    end
  end

  path '/help_centre/question_answer/{id}' do
    get 'Get a question answer' do
      tags 'bx_block_help_centre', 'question_answer', 'show'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :string, example: "1", required: true

      let!(:question_answer2) { create :question_answer, question_sub_type: question_sub_type1 }
      let(:id) { question_answer2.id }

      response '200', :success do
        schema '$ref' => '#/components/schemas/question_answer'
        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data['attributes']['id']).to eq question_answer2.id
          expect(data['attributes']['question']).to eq question_answer2.question
          expect(data['attributes']['answer']).to eq question_answer2.answer
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
                  type: :string, example: "Expired token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 401 }
      end
    end

    put 'Update a question answer' do
      tags 'bx_block_help_centre', 'question_answer', 'update'
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :string, example: "1", required: true
      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          attributes: {
            type: :object,
            properties: {
              question: { type: :string, example: "Test Question 1" },
              answer: { type: :string, example: "Test Answer 1" },
              question_sub_type_id: { type: :integer, example: 1 }
            }
          }
        }
      }, required: true

      let!(:question_answer3) { create :question_answer, question_sub_type: question_sub_type1 }
      let(:id) { question_answer3.id }
      let(:data) {{
        data: {
          attributes: {
            question: "Test Question 2",
            answer: "Test Answer 2",
            question_sub_type_id: question_sub_type1.id
          }
        }
      }}

      response '200', :success do
        schema '$ref' => '#/components/schemas/question_answer'
        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data['attributes']['id']).to eq question_answer3.id
          expect(data['attributes']['question']).to eq "Test Question 2"
          expect(data['attributes']['answer']).to eq "Test Answer 2"
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
                  type: :string, example: "Expired token"
                }
              }
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 401 }
      end
    end

    delete 'Delete a question answer' do
      tags 'bx_block_help_centre', 'question_answer', 'delete'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :string, example: "1", required: true

      let!(:question_answer4) { create :question_answer, question_sub_type: question_sub_type1 }
      let(:id) { question_answer4.id }

      response '200', :success do
        schema '$ref' => '#/components/schemas/question_answer'
        run_test! do |response|
          expect(response.status).to eq 200

          json = JSON.parse(response.body)

          expect(json['message']).to eq "Question answer deleted."
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
                  type: :string, example: "Expired token"
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
