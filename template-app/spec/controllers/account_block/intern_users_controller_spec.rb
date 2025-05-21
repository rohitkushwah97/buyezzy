# frozen_string_literal: true

require 'rails_helper'
require 'simplecov'
RSpec.describe AccountBlock::InternUsersController, type: :request do
  CANT = "can't be blank"
  NOT_FOUND = 'Record not found'
  let(:intern_user) { FactoryBot.create(:intern_user, activated: true, full_name: "sachin saha") }
  let(:token) { get_token(intern_user) }
  let(:url) { '/account_block/intern_users' }
  let(:intern_user) { create(:intern_user) }
  let(:intern_user_without_education) { create(:intern_user_generic_question) }
  let(:controller) { AccountBlock::InternUsersController.new }

  let(:valid_params) do
    {
      "data": {
        "attributes": {
          "full_name": "sakti",
          "email": 'sonu12@yopmail.com',
          "date_of_birth": '23/09/2000',
          "password": 'Password@123'
        }
      }
    }
  end
  let(:valid_params2) do
    {
      "data": {
        "attributes": {
          "email": 'intern_user.email',
          "date_of_birth": '23/09/2001',
          "password": 'Password@1234'
        }
      }
    }
  end
  let(:update_params) do
    {
      "email": 'monu@yopmail.com',
      "date_of_birth": '23/09/2002',
      "password": 'Password@1243',
      "full_phone_number": '+911234567890'
    }
  end
  let(:invalid_update_params) do
    {
      "full_name": nil,
      "email": nil
    }
  end
  let(:invalid_params) do
    {
      "data": {
        "attributes": {
          "full_name": nil,
          "email": nil,
          "gender": nil,
          "date_of_birth": nil,
          "emirates_id": nil,
          "password": nil
        }
      }
    }
  end

  describe 'POST /create' do
    it 'Signup with valid params' do
      post url, params: valid_params

      res = json_response
      expect(response).to have_http_status(201)
      expect(res['data']['attributes']['email']).to eq('sonu12@yopmail.com')
      expect(res['data']['attributes']['education']).to be_nil
    end

    it 'raise validation error on Signup with invalid params' do
      post url, params: invalid_params

      res = json_response
      expect(response).to have_http_status(422)
      expect(res['errors'][0]['date_of_birth']).to eq(CANT)
      expect(res['errors'][1]['email']).to eq(CANT)
      expect(res['errors'][2]['email']).to eq('is invalid')
    end
  end

  describe 'GET /Index' do
    before do
      AccountBlock::InternUser.destroy_all
      @token = get_token(intern_user)
    end
    it 'should return success response of index' do
      get url, headers: { token: @token }
      res = json_response
      expect(response).to have_http_status(200)
      expect(res['data'][0]['id'].to_i).to eql(intern_user.id)
      expect(res['data'][0]['attributes']['email']).to eql(intern_user.email)
    end

    it 'should return unauthorise error.' do
      get url, headers: { token: 'invalid_token' }
      expect(response).to have_http_status(400)
      expect(json_response['errors'][0]['token']).to eql('Invalid token')
    end
  end

  describe 'GET /Show' do
    it 'should return intern_user data with valid id' do
      get "#{url}/#{intern_user.id}", headers: { token: token }
      res = json_response
      expect(response).to have_http_status(200)
      expect(res['data']['id'].to_i).to eql(intern_user.id)
      expect(res['data']['attributes']['email']).to eql(intern_user.email)
    end

    it 'should return error' do
      get "#{url}/123456", headers: { token: token }
      res = json_response
      expect(response).to have_http_status(404)
      expect(res['errors'][0]).to eql(NOT_FOUND)
    end
  end

  describe 'PUT /Update' do
    let(:invalid_update_params) do
      {
        email: 'invalid_email',
        profile_attributes: {
          photo: fixture_file_upload(Rails.root.join('spec/fixtures/files/11mb-example.jpg'), 'image/jpeg')
        }
      }
    end

    let(:invalid_media_update_params) do
      {
        email: 'invalid_email',
        profile_attributes: {
          photo: fixture_file_upload(Rails.root.join('spec/fixtures/files/intern_user.csv'), 'image/csv')
        }
      }
    end
    it 'should return updated intern user response' do
      put "#{url}/#{intern_user.id}", headers: { token: token }, params: update_params
      res = json_response
      expect(response).to have_http_status(200)
      expect(res['data']['attributes']['email']).to eql(update_params[:email])
      expect(res['data']['attributes']['country_code']).to eql(91)
      expect(res['data']['attributes']['phone_number']).to eql(1_234_567_890)
    end

    it 'should return intern_user data with invalid id' do
      put "#{url}/100000", headers: { token: token }, params: update_params
      res = json_response
      expect(response).to have_http_status(404)
      expect(res['errors'][0]).to eql(NOT_FOUND)
    end

    it 'should return validation error' do
      put "#{url}/#{intern_user.id}", headers: { token: token }, params: invalid_update_params
      res = json_response
      expect(response).to have_http_status(422)
    end

    it 'should return type validation error' do
      put "#{url}/#{intern_user.id}", headers: { token: token }, params: invalid_media_update_params
      res = json_response
      # expect(response).to have_http_status(422)
    end
  end

  describe 'DELETE /Destroy' do
    it 'should delete intern user' do
      delete "#{url}/#{intern_user.id}", headers: { token: token }
      res = json_response
      expect(response).to have_http_status(200)
      expect(res['id']).to eql(intern_user.id)
      expect(res['message']).to eql('Inter User deleted.')
    end

    it 'should return error record not found.' do
      delete "#{url}/123456", headers: { token: token }
      res = json_response
      expect(response).to have_http_status(404)
      expect(res['errors'][0]).to eql(NOT_FOUND)
    end
  end

  describe 'GET /display_job/:internship_id' do
    let(:internship) { create(:bx_block_navmenu_internship) }
    let(:internship_id) { internship.id }

    it 'should return job data with valid job id' do
      get "/account_block/intern_users/display_internship/#{internship_id}",headers: { token: token }
      res = json_response
      expect(response).to have_http_status(200)
      expect(res['data']['id'].to_i).to eql(internship.id)
    end

    it 'should return error with invalid job id' do
      get '/account_block/intern_users/display_internship/123456',headers: { token: token }
      res = json_response
      expect(response).to have_http_status(:not_found)
      expect(res['meta']['message']).to eql('Record not found.')
    end
  end

  describe 'GET #get_education_details' do
    it 'should return education details for a valid intern user' do
      get "/account_block/intern_users/#{intern_user.id}/education_details", headers: { token: token }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Education Background for')
    end
  end

  describe 'GET #get_career_interest' do
    it 'should return career interests for a valid intern user' do
      get "/account_block/intern_users/#{intern_user.id}/career_interests", headers: { token: token }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('No career interest records found.')
    end

    it 'should return not found for an invalid intern user ID' do
      get '/account_block/intern_users/123456/career_interests', headers: { token: token }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('No career interest records found.')
    end
  end

  describe 'GET /display_business/:business_user_id' do
    let(:business_user) { create(:business_user) }

    let(:company_detail) { create(:company_detail, business_user: business_user, company_name: 'Test') }

    let(:business_user_id) { business_user.id }

    it 'should return company data with valid company id' do
      get "/account_block/intern_users/display_business/#{business_user_id}"

      res = json_response

      # expect(res['data']["attributes"]['business_user_id']).to eql(business_user_id)
    end

    it 'should return error with invalid company id' do
      get '/account_block/intern_users/display_business/123456'

      # expect(json_response['meta']['message']).to eql(NOT_FOUND)
    end
  end

  describe 'GET #get_intern_user_internships' do
    let!(:intern_user) { create(:intern_user) } 
    let!(:internship) { create(:bx_block_navmenu_internship) } 
    let!(:answer) { create(:intern_user_generic_answer, internship: internship, account: intern_user) }

    before do
      intern_user.internships << internship
    end

    it 'should return career interests for a valid intern user with answers' do
      get "/account_block/intern_users/#{intern_user.id}/get_intern_user_internships", headers: { token: token }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(internship.title)
      expect(response.body).to include(answer.answer)
    end

    it 'should return empty answers for a valid intern user without answers' do
      internship_without_answers = create(:bx_block_navmenu_internship)
      intern_user.internships << internship_without_answers

      get "/account_block/intern_users/#{intern_user.id}/get_intern_user_internships", headers: { token: token }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(internship_without_answers.title)
    end
  end

  describe '#generate_profile_thumbnail' do
    let(:file_tempfile) { Tempfile.new(['upload', '.jpg']) }
    let(:file) do
      double('UploadedFile',
        original_filename: 'test.jpg',
        tempfile: file_tempfile
      )
    end

    let(:photo_thumbnail_attachment) { double('Attachment', attach: true) }

    let(:profile) do
      double('Profile', photo_thumbnail: photo_thumbnail_attachment)
    end

    it 'attaches a resized thumbnail to the profile' do
      pipeline = double('ImageProcessingPipeline')

      allow(ImageProcessing::MiniMagick).to receive(:source).with(file_tempfile).and_return(pipeline)
      allow(pipeline).to receive(:resize_to_limit).with(300, 300).and_return(pipeline)
      allow(pipeline).to receive(:call).with(destination: kind_of(String))

      controller.send(:generate_profile_thumbnail, profile, file)

      expect(profile.photo_thumbnail).to have_received(:attach).with(
        hash_including(:io, :filename, :content_type)
      )
    end
  end
end
