require 'rails_helper'

RSpec.describe BxBlockSupport::SocialPlatformsController, type: :controller do

  before(:all) do
    BxBlockSupport::SocialPlatform.all.delete_all
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @social_media = 'https://www.facebook.com/example'
    @social_platform = create(:social_platform, social_media: 'Facebook', social_media_url: @social_media)
  end

  describe 'GET index' do
    it 'returns a list of social platforms' do
      get :index, params: {token: @token}
      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body).size).to eq(BxBlockSupport::SocialPlatform.all.count)
      expect(JSON.parse(response.body)[0]['social_media']).to eq('Facebook')
      expect(JSON.parse(response.body)[0]['social_media_url']).to eq(@social_media)
    end
  end

  describe 'GET show' do
    it 'returns a single social platform' do
      get :show, params: { id: @social_platform.id, token: @token }
      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)['social_media']).to eq('Facebook')
      expect(JSON.parse(response.body)['social_media_url']).to eq(@social_media)
      expect(JSON.parse(response.body)['social_icon']).to include(Rails.application.routes.url_helpers.rails_blob_path(@social_platform.social_icon, only_path: true))
    end

    it 'returns not found for an invalid ID' do
      get :show, params: { id: 'invalid_id' }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors'][0]).to eq('Record not found')
    end
  end
end
