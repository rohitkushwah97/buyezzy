# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/activity_feed', :jwt do
  let(:headers) { { token: token } }
  let(:token) { jwt }
  let(:json_response) { JSON response.body }
  let(:account) { create :account, type: 'SmsAccount', activated: true, last_visit_at: '2023-01-30T06:32:31.563Z' }
  let(:account1) { create(:account, type: 'SmsAccount', activated: true) }
  let(:id) { account.id }
  let!(:order) { create(:order, account: account) }
  let!(:chat) { create(:chat, name: 'test') }
  let!(:post) { FactoryBot.create(:post, account_id: account.id) }

  path '/activity_feed/activity_feeds/account_feeds' do
    get 'Account Feed' do
      produces 'application/json'
      tags 'bx_block_activity_feed', 'activity_feeds', 'account_feeds'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true
      let!(:activity1) do
        PublicActivity::Activity.create(owner_type:
        'AccountBlock::Account', owner_id: account.id,
                                        trackable_type: 'AccountBlock::Account', trackable_id: account.id)
      end

      response '200', :success do
        schema '$ref' => '#/components/schemas/activity_feed'
        context 'will render activity record' do
          run_test! do |response|
            expect(response.content_type).to eq('application/json; charset=utf-8')
            expect(response).to have_http_status(200)
            expect(json_response['activities'][0]['id']).to eq(activity1.id)
          end
        end
      end
    end
  end

  path '/activity_feed/export_csv' do
    get 'Export CSV of  Activity Feed' do
      produces 'application/json'
      tags 'bx_block_activity_feed', 'activity_feeds', 'export_csv'
      parameter name: 'token', in: :header, type: :string, example: '{{bx_blocks_api_token}}', required: true

      let!(:activity1) do
        PublicActivity::Activity.create(owner_type:
        'AccountBlock::Account', owner_id: account.id,
                                        trackable_type: 'AccountBlock::Account', trackable_id: account.id)
      end

      let!(:activity2) do
        PublicActivity::Activity.create(owner_type:
        'AccountBlock::Account', owner_id: account.id,
                                        trackable_type: 'BxBlockOrderManagement::Order', trackable_id: order.id)
      end

      let!(:activity3) do
        PublicActivity::Activity.create(owner_type:
        'AccountBlock::Account', owner_id: account.id,
                                        trackable_type: 'BxBlockChat::Chat', trackable_id: chat.id)
      end

      response '200', :success do
        run_test! do |response|
          expect(response.content_type).to eq('text/csv; charset=iso-8859-1')
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
