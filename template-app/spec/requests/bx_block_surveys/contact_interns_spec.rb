require 'rails_helper'

RSpec.describe BxBlockSurveys::ContactInternsController, type: :controller do
  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let(:intern_token) { get_token(intern_user) }
  let(:intern_user2) { FactoryBot.create(:intern_user, activated: true) }
  let(:business_user) { FactoryBot.create(:business_user, activated: true) }
  let(:business_user2) { FactoryBot.create(:business_user, activated: true) }
  let(:business_token2) { get_token(business_user2) }
  let(:business_token) { get_token(business_user) }
  let(:internship) { FactoryBot.create(:bx_block_navmenu_internship, business_user_id: business_user.id,status: 1) }
  let(:internship2) { FactoryBot.create(:bx_block_navmenu_internship, business_user_id: business_user2.id,status: 1) }
  let!(:contact_intern) { FactoryBot.create(:contact_intern, internship_id: internship.id, intern_user_id: intern_user.id,decision:1) }
  let(:contact_interns_list) { FactoryBot.create_list(:contact_intern,2, internship_id: internship.id,decision:2) }
  let(:body) { JSON.parse(response.body) }

  describe 'GET #index' do
    it 'returns Contact Interns' do
      get :index, params: { token: business_token}
      expect(response).to have_http_status 200
      expect(body['data'][0]['id'].to_i).to eq(contact_intern.id)
    end

    it 'returns Contact Interns' do
      internship2
      get :index, params: { token: business_token2}
      expect(response).to have_http_status 404
      expect(body['data']).to eq([])
    end

    it 'search Contact Interns' do
      get :index, params: { token: business_token, search: intern_user.full_name}
      expect(response).to have_http_status 200
      expect(body['data'][0]['attributes']['intern_user']['data']['attributes']['full_name']).to eq(intern_user.full_name)
    end
  end

  describe 'POST #create' do
    it 'create Contact Interns' do
      internship.accounts << intern_user2
      post :create, params: { intern_user_id: intern_user2.id,token: business_token}
      expect(response).to have_http_status 201
      expect(body['message']).to eq("Contacted successfully")
      expect(body['contacted']).to eq(true)
    end

    it 'returns Contact Interns need to apply' do
      post :create, params: { intern_user_id: intern_user.id,token: business_token}
      expect(response).to have_http_status 422
      expect(body['error']).to eq("User needs to apply for internship")
    end

     it 'returns You can not contact one intern more then one' do
      internship.accounts << intern_user
      post :create, params: { intern_user_id: intern_user.id,token: business_token}
      expect(response).to have_http_status 422
      expect(body['error']).to eq("You can not contact one intern more then one")
    end
  end

  describe 'PUT #update' do
    let(:intern_user) { create(:intern_user) }
    let(:internship) { create(:bx_block_navmenu_internship, title: "Sample Internship") }
    let(:contact_intern) { create(:contact_intern, intern_user: intern_user, internship: internship, decision: 0) }
    let(:business_user) { internship.business_user }

    before do
      allow(AccountBlock::InternUser).to receive(:find).with(contact_intern.intern_user_id).and_return(intern_user)
    end

    context 'when decision is 1' do
      it 'updates Contact Interns and sends a notification' do
       
        put :update, params: { id: contact_intern.id, decision: 1, token: business_token }

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['message']).to eq("updated successfully")
      end
    end

    context 'when decision is invalid' do
      it 'does not update Contact Interns and returns an error' do
        put :update, params: { id: contact_intern.id, decision: 5, token: business_token }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['error']).to eq("'5' is not a valid decision")
      end
    end
  end

  describe 'POST #unlock_candidates' do
    it 'unlock_candidates' do
      contact_interns_list
      contact_intern.update(decision:2)
      internship.accounts << intern_user2
      post :unlock_candidates, params: {token: business_token}
      expect(response).to have_http_status 200
      expect(body['message']).to eq("created.")
    end

     it 'for unlock_candidates atleast 3 contact_intern needed' do
      post :unlock_candidates, params: {token: business_token}
      expect(response).to have_http_status 422
      expect(body['error']).to eq("You need to contact atleast 3 candidates.")
    end
  end

  describe 'GET #get_contacted_applications' do
    it 'returns offer made internships for intern user' do
      get :get_contacted_applications, params: { token: intern_token}
      expect(response).to have_http_status 200
      expect(body['data'][0]['id'].to_i).to eq(contact_intern.internship_id)
    end
  end
end

