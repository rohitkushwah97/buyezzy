require 'swagger_helper'

RSpec.describe '/bx_block_notifications', :jwt do

  let(:headers) { {:token => token} }

  let(:json)   { JSON response.body }
  let(:data)   { json['data'] }
  let(:token)  { jwt }
  let(:attributes) { data['attributes']}
  let(:errors) { json['errors'] }
  let(:error)  { errors.first }
  let(:model_errors) { data['attributes']['errors'] }
  let(:model_error)  { errors.first }

  let(:account) { create :email_account }
  let(:id)      { account.id }

  path '/notifications/notifications/' do
    post 'Create Notification' do
      consumes "application/json"
      produces "application/json"
      tags "bx_block_notifications", "Notification", "create"
      parameter name: 'token', in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          created_by: { type: :integer },
          headings: { type: :string },
          contents: { type: :string },
          app_url: { type: :string },
          is_read: { type: :boolean }
        }
      }

      let(:params) do
{
        notification: {
          created_by: 1,
          headings: 'test2',
          contents: 'new_content',
          app_url: 'static',
          is_read: true
        }
      }
      end

      response '201', :success do
        context 'add notification ' do
          run_test! do |response|
          expect(response.status).to eq 201
          expect(BxBlockNotifications::Notification.count).to eq 1
          end
        end
      end

      response '422', :success do
        context 'unable to create notification ' do
          let(:params) do
            {
                    notification: {
                      created_by: "",
                      headings: '',
                      contents: '',
                      app_url: '',
                      is_read: ""
                    }
                  }
                  end
          run_test! do |response|
          expect(response.status).to eq 422
          
          end
        end
      end

      response '400', :unauthorized do
        let(:token)  { '' }

        run_test!
      end

      response '401', :unauthorized do
        let(:token)  { jwt_expired }

        run_test!
      end
    end

    get 'List Notification' do
      tags 'Notification'
      consumes "application/json"
      produces "application/json"
      parameter name: 'token', in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      

      response '200', :success do
        schema '$ref' => '#/components/schemas/notification'
        context 'returns no notifications' do
         
          run_test! do |response|
          expect(response.status).to eq 200
          end
        end

        context 'returns list of  notification of user' do
          let!(:notification1) { create :notification, account: account }
          let!(:notification2) { create :notification, account: account }
          run_test! do |response|
          expect(response.status).to eq 200
          end
        end

        response '400', :unauthorized do
          let(:token)  { '' }

          run_test!
        end
      end
    end
  end

   path '/notifications/notifications/{notification_id}' do
    get 'Show Notification' do
      consumes "application/json"
      produces "application/json"
      tags "bx_block_notifications", "Notification", "index"
     
      parameter name: 'token', in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :notification_id, in: :path, type: :integer

      let!(:notification) { create :notification, account: account }

      let(:notification_id) { notification.id }

      response '200', :success do
        schema '$ref' => '#/components/schemas/notification'
         context 'returns notification exist or not' do
          run_test! do |response|
          expect(response.status).to eq 200
          expect(data['attributes']['id']).to eq notification.id
          expect(data['attributes']['headings']).to eq notification.headings
          end
        end
      end
    end

    put 'Update Notification' do
      consumes "application/json"
      produces "application/json"
      tags "bx_block_notifications", "Notification", "update"
     
      parameter name: 'token', in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :notification_id, in: :path, type: :integer

      let!(:notification) { create :notification, account:account }


      let(:notification_id) { notification.id }

      context 'given valid parameters' do
        response '200', :success do
          schema '$ref' => '#/components/schemas/notification'
          context 'marks notification as read' do
            run_test! do |response|
            expect(response.status).to eq 200
            end
          end
        end
      end
    end

    delete 'Delete a Notification' do
      consumes "application/json"
      produces "application/json"
      tags "bx_block_notifications", "Notification", "delete"
 
      parameter name: 'token', in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :notification_id, in: :path, type: :integer

      let!(:notification) { create :notification, account:account }

      let(:notification_id) { notification.id }

      response '200', :success do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        context 'Should have status 200' do
          run_test! do |response|
          expect(response.status).to eq 200
          end
        end

        context 'delete notification ' do
          run_test! do |response|
          expect(json['message']).to eq "Deleted."
          end
        end
      end
    end
  end
end
