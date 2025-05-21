require 'rails_helper'

RSpec.describe BxBlockLike::LikesController, type: :controller do

  let!(:account) { create(:business_user, email: 'business@example.com', activated: true) }
  let(:account2) { create(:business_user, activated: false) }
  let(:post_data) { "BxBlockPosts::Post" }
  before do
    @token = BuilderJsonWebToken.encode(account.id)
    @token2 = BuilderJsonWebToken.encode(account2.id)
    @post = FactoryBot.create(:post, account_id: account.id)
    @post2 = FactoryBot.create(:post, account_id: account.id)
  end

  describe "create like" do
    let(:params) do {
      likeable_id: @post.id,
      likeable_type: post_data,
      token: @token
    }
    end

    let(:params2) do {
      likeable_type: post_data,
      token: @token
    }
    end

    it "When like is successfully created" do
      post :create, params: params
      expect(response).to have_http_status :created
      expect(JSON.parse(response.body)['data']['type']).to eq("like")
    end

    it "When like is not created" do
      post :create, params: params2
      expect(response).to have_http_status :unprocessable_entity
      expect(JSON.parse(response.body)['errors'][0]['like'][0]).to eq("Likeable must exist")
    end
  end

  describe "delete a like" do

    it "When like is delete successfully" do
      BxBlockLike::Like.create(likeable_id: @post.id, likeable_type: post_data, like_by_id: account.id)
      delete :destroy, params: {likeable_id: @post.id, likeable_type: "post", token: @token}
      data = JSON.parse(response.body)["message"]
      expect(data).to eq "Like is removed "
      expect(response).to have_http_status :ok
    end

    it "When like is not deleted" do
      delete :destroy, params: {likeable_id: 0, likeable_type: "post", token: @token}
      data = JSON.parse(response.body)["message"]
      expect(data).to eq "Not found"
      expect(response).to have_http_status :not_found
    end
  end

  describe "#get_likes_on_a_post" do

    it "returns likes when likes are present on the post with pagination" do
      BxBlockLike::Like.create(likeable_id: @post.id, likeable_type: post_data, like_by_id: account.id)
      get :get_likes_on_a_post, params: {likeable_id: @post.id, page: 1,per_page: 1, token: @token}
      data = JSON.parse(response.body)['data']
      meta = JSON.parse(response.body)['meta']
      expect(data.first['type']).to eq('like')
      expect(response).to have_http_status :ok
      expect(meta["pagination"]["current_page"]).to eq(1)
      expect(meta["pagination"]["per_page"]).to eq(1)
    end

    it "returns 'No likes.' when likes are not present on a post" do
      @post.destroy
      get :get_likes_on_a_post, params: {likeable_id: @post.id, token: @token}
      data = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(data['errors'].first['message']).to eq("No likes.")
    end
  end
end