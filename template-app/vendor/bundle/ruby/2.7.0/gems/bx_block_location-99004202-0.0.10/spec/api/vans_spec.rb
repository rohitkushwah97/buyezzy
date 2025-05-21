require 'spec_helper'
require 'rails_helper'

RSpec.describe '/location', :jwt do
  let(:headers) { {:token => token} }

  let(:json)   { JSON response.body }
  let(:data)   { json['data'] }
  let(:token)  { jwt }
  let(:errors) { json['errors'] }
  let(:error)  { errors.first }
  let(:model_errors) { data['attributes']['errors'] }
  let(:model_error)  { errors.first }

  let(:role)       { create :role, name: 'admin' }
  let(:account)    { create :email_account, role_id: role.id }
  let(:id)         { account.id }
  let!(:van)       { create :van, service_provider: account }

  let!(:van_member) { create :van_member, account: account, van: van }

  before do
    van.location.latitude = 22.9734229
    van.location.longitude = 78.6568942
    van.location.locationable_type = "BxBlockLocation::Van"
    van.location.locationable_id = van.id
    van.location.save
  end

  describe 'GET /location/vans/:id' do
    let(:endpoint) { "/location/vans/#{van.id}" }

    it 'Check van location' do
      get endpoint, headers: headers
      json_response = JSON.parse(response.body)
      expect(json_response['meta']['message']).to eq "Location of van"
      expect(response.status).to eq 200
    end
  end

  describe 'PUT /location/vans/:id' do
    let(:endpoint) { "/location/vans/#{van.id}" }

    context 'all parameters valid' do
      let(:params) {{
        id: van.id, latitude: 22.9734229, longitude: 78.6568942
      }}

      it 'updates van location' do
        put endpoint, headers: headers, params: params
        expect(json['meta']['message']).to eq 'Location updated successfully'
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET /location/vans/near_vans' do
    let(:endpoint) { '/location/vans/near_vans' }
    let!(:availability) {
      create :availability,
             start_time: '10:00 AM',
             end_time: '10:00 PM',
             availability_date: Date.today.strftime('%d/%m/%y'),
             service_provider: account
    }

    context 'provided with a close location' do
      let(:params) {{
        latitude: 22.9734229, longitude: 78.6568942,locationable_id: van.id, locationable_type: "BxBlockLocation::Van"
      }}

      before do
        van.is_offline = false
        van.save
      end

      it 'gives van details in the response' do
        get endpoint, headers: headers, params: params
        expect(json['message']).to eq "No van's present near your location"
        expect(response.status).to eq 200
      end
    end

    context 'van is far from given location' do
      let(:params) {{
        latitude: 22.9734229, longitude: 78.6568942,locationable_id: van.id, locationable_type: "BxBlockLocation::Van"
      }}

      before do
        van.location.update(latitude: 40.9734229, longitude: 10.6568942,locationable_id: van.id, locationable_type:"BxBlockLocation::Van")
      end

      it 'gives message about no van near' do
        get endpoint, headers: headers, params: params
        expect(json['message']).to eq 'No van\'s present near your location'
        expect(response.status).to eq 200
      end
    end

    context 'part of location is missing' do
      let(:params) {{
        id: van.id, longitude: 78.6568942
      }}

      it 'returns an error about location' do
        get endpoint, headers: headers, params: params
        expect(errors).to eq 'Please send location'
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET /location/vans/estimated_arrival_time' do
    let(:endpoint) { '/location/vans/estimated_arrival_time' }

    let!(:address) { create :address, addressble_id: account.id }

    context 'provided with a close location' do
      let(:params) {{
        service_provider_id: account.id,
        address_id: address.id
      }}

      before do
        van.is_offline = false
        van.save
      end

      it 'gives van details in the response' do
        get endpoint, headers: headers, params: params
        expect(json['estimated_time']).not_to eq(nil)
        expect(response.status).to eq 200
      end
    end
  end
end
