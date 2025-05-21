# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/settings' do
  let(:json)   { JSON response.body }
  let(:meta)   { json['meta'] }
  let(:errors) { json['errors'] }
  let(:error)  { errors.first }

  describe 'GET /settings/setting' do
    let!(:setting1) do
      BxBlockSettings::Setting.create!(
        title: 'Setting title 1',
        name: 'Setting name 1'
      )
    end

    let!(:setting2) do
      BxBlockSettings::Setting.create!(
        title: 'Setting title 2',
        name: 'Setting name 2'
      )
    end

    before do
      get '/settings/settings'
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns successfully loaded message' do
      expect(json).to include('message' => 'Successfully loaded')
    end

    describe 'the response body' do
      let(:settings) { json['settings'] }
      it 'returns all the settings' do
        expect(settings.length).to eq(2)
      end

      it 'returns the first setting' do
        expect(settings.first).to include(
                                    'title' => 'Setting title 1',
                                    'name' => 'Setting name 1'
                                  )
      end

      it 'returns the first setting' do
        expect(settings.second).to include(
                                     'title' => 'Setting title 2',
                                     'name' => 'Setting name 2'
                                   )
      end
    end
  end
end
