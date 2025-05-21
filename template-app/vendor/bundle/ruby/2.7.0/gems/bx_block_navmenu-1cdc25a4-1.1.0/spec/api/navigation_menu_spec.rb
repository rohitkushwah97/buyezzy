# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/navigation_menu', :jwt do
  let(:headers) { { token: token } }
  let(:token) { jwt }
  let(:account) { create :email_account }
  let(:id) do
    account.id
  end

  let(:json)   { JSON response.body }
  let(:meta)   { json['meta'] }
  let(:errors) { json['errors'] }
  let(:error)  { errors.first }

  describe 'POST /navbar/navigation_menu' do
    let(:left_navbar) { { 'name' => 'Test', 'url' => 'https://test.com' } }
    let(:params) do
      {
        data: {
          attributes: {
            left: [left_navbar],
          }
        }
      }
    end

    before { expect(BxBlockNavmenu::NavigationMenu.count).to eq(0) }

    before do
      post '/navmenu/navigation_menu', params: params, headers: headers
    end

    it 'creates the navbars' do
      expect(BxBlockNavmenu::NavigationMenu.count).to eq(1)
    end

    it 'returns the navbar' do
      navbar = json.first

      expect(navbar['position']).to eq('left')
      expect(navbar['items']).to include(left_navbar)
    end

    it 'returns a token' do
      expect(response.status).to eq 200
    end
  end

  describe 'GET /navbar/navigation_menu' do
    let(:params) do
      {
        data: {
          attributes: {
            left: [{ "name": 'Test', "url": 'https://test.com' }],
            right: [{ "name": 'Test1', "url": 'https://test1.com' }]
          }
        }
      }
    end

    before do
      post '/navmenu/navigation_menu', params: params, headers: headers
      get '/navmenu/navigation_menu', headers: headers
    end

    it 'returns the status :ok' do
      expect(response.status).to eq(200)
    end

    it 'returns the representation of the navbars ' do
      expect(response.body).to include('Test')
      expect(response.body).to include('Test1')
    end

    it 'returns the navbars' do
      expect(json.length).to eq(2)
    end
  end
end
