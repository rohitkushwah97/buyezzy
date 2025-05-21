require 'rails_helper'
require 'swagger_helper'

RSpec.describe "/email_notifications", :jwt do
  let(:current_user) { create(:account, email: 'current@example.com') }
  let(:other_user) { create(:account) }

  let(:token)  { BuilderJsonWebToken.encode(current_user.id, 1.day.from_now, token_type: "login") }
  let(:jwt_expired) { BuilderJsonWebToken.encode(current_user.id, 1.day.ago, token_type: "login") }

  let(:notification) { create(:notification, account: current_user) }
  let(:other_user_notification) { create(:notification, account: other_user) }

  path '/email_notifications/email_notifications' do
    post 'Sends an email notification' do
      tags 'bx_block_email_notifications', 'email_notifications', 'create'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :notification_id, in: :query, type: :integer, required: true

      let(:email_notification) do
        create(:email_notification,
               notification: notification,
               send_to_email: notification.account.email,
               sent_at: Time.zone.now)
      end

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/email_notification'

        let(:notification_id) { notification.id }

        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data["attributes"]["notification"]["id"]).to eq(notification.id)
          expect(data["attributes"]["send_to_email"]).to eq("current@example.com")
          expect(data["attributes"]["sent_at"]).to eq(nil)
        end
      end

      response "200", "calls SendEmailNotificationService to create the email notification and send the email" do
        schema '$ref' => '#/components/schemas/email_notification'

        let(:notification_id) { notification.id }
        let!(:service) { instance_spy(BxBlockEmailNotifications::SendEmailNotificationService) }

        before do |example|
          allow(BxBlockEmailNotifications::SendEmailNotificationService)
            .to receive(:new).and_return(service)
          allow(service).to receive(:call).and_return(email_notification)

          submit_request(example.metadata)
        end

        run_test! do |response|
          expect(response.status).to eq 200
          expect(service).to have_received(:call).at_least(:once)
        end
      end

      response "404", "when the provided notifiaction id does not exist" do
        let(:notification_id) { -1 }

        run_test! do |response|
          expect(response.status).to eq 404

          errors = JSON.parse(response.body)['errors']

          expect(errors[0]["message"]).to eq("Notification not found.")
        end
      end

      response "404", "when the provided notifiaction id belongs to another user account" do
        let(:notification_id) { other_user_notification.id }

        run_test! do |response|
          expect(response.status).to eq 404

          errors = JSON.parse(response.body)['errors']

          expect(errors[0]["message"]).to eq("Notification not found.")
        end
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }
        let(:notification_id) { notification.id }

        schema type: :object,properties:{
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string,example: "Invalid token"
                }
              },
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 400 }
      end
    end
  end

  path '/email_notifications/email_notifications/{id}' do
    get 'Returns an email notification' do
      tags 'bx_block_email_notifications', 'email_notifications', 'show'
      produces "application/json"
      parameter name: :token, in: :header, type: :string, example: "{{bx_blocks_api_token}}", required: true
      parameter name: :id, in: :path, type: :integer, required: true

      let(:email_notification) do
        create(:email_notification,
               notification: notification,
               send_to_email: notification.account.email,
               sent_at: Time.zone.now)
      end

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/email_notification'

        let(:id) { email_notification.id }

        run_test! do |response|
          expect(response.status).to eq 200

          data = JSON.parse(response.body)['data']

          expect(data["attributes"]["notification"]["id"]).to eq(notification.id)
          expect(data["attributes"]["send_to_email"]).to eq("current@example.com")
          expect(data["attributes"]["sent_at"]).not_to be_nil
        end
      end

      response "200", 'when the provided id belongs to a email notification that has been sent already' do
        schema '$ref' => '#/components/schemas/email_notification'

        let(:id) { email_notification.id }

        before do
          email_notification.update(sent_at: Time.zone.now)
        end

        run_test! do |response|
          expect(response.status).to eq 200

          json = JSON.parse(response.body)

          expect(json["data"]["attributes"]["notification"]["id"]).to eq(notification.id)
          expect(json["data"]["attributes"]["send_to_email"]).to eq("current@example.com")
          expect(json["data"]["attributes"]["sent_at"]).to eq(email_notification.sent_at.iso8601(3))
        end
      end

      response "404", "when the provided id does not exist" do
        let(:id) { -1 }

        run_test! do |response|
          expect(response.status).to eq 404

          errors = JSON.parse(response.body)['errors']

          expect(errors[0]["message"]).to eq("Email Notification not found.")
        end
      end

      response "404", "when the provided id belongs to another user account" do
        let(:id) { other_user_notification.id }

        run_test! do |response|
          expect(response.status).to eq 404

          errors = JSON.parse(response.body)['errors']

          expect(errors[0]["message"]).to eq("Email Notification not found.")
        end
      end

      response "400", :unauthorized do
        let(:token) { "invalid_token" }
        let(:id) { email_notification.id }

        schema type: :object, properties: {
          errors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                token: {
                  type: :string,example: "Invalid token"
                }
              },
            }
          }
        }

        run_test! { |response| expect(response.status).to eq 400 }
      end
    end
  end
end
