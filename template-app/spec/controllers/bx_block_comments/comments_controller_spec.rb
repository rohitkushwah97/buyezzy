require 'rails_helper'

RSpec.describe BxBlockComments::CommentsController, type: :controller do
  let!(:account) { create(:business_user, email: 'business@example.com', activated: true) }

  # let(:account) { FactoryBot.create(:account) }
  let(:post_data) { "BxBlockPosts::Post" }
  before do
    @token = BuilderJsonWebToken.encode(account.id)
    @token2 = BuilderJsonWebToken.encode(0)
    @post = FactoryBot.create(:post, account_id: account.id)
    @comment = BxBlockComments::Comment.create(commentable_id: @post.id, commentable_type: post_data, comment: Faker::Lorem.paragraphs.first, account_id: account.id)
    @like = BxBlockLike::Like.create(likeable_id: @post.id, likeable_type: post_data, like_by_id: account.id)
  end

  describe "create comment" do
    let(:params) do {
      commentable_id: @post.id,
      commentable_type: post_data,
      comment: Faker::Lorem.paragraphs.first,
      token: @token
    }
    end

    let(:params2) do {
      commentable_id: @post.id,
      commentable_type: post_data,
      comment: "",
      token: @token
    }
    end

    let(:params3) do {
      commentable_id: @post.id,
      commentable_type: "comment",
      comment: Faker::Lorem.paragraphs.first,
      token: @token
    }
    end

    it "When comment is successfully created" do
      post :create, params: params
      expect(response).to have_http_status :created
      expect(JSON.parse(response.body)['message']).to eq("comment created succesfully")
    end

    it "When comment is not created" do
      post :create, params: params2
      expect(response).to have_http_status :unprocessable_entity
      expect(JSON.parse(response.body)['errors'][0]['comment']).to eq("can't be blank")
    end

    it "When commentable type is diffrent" do
      post :create, params: params3
      expect(response).to have_http_status :bad_request
      expect(JSON.parse(response.body)['error']).to eq("Only BxBlockComments::Comment or BxBlockPosts::Post can be used for comment type")
    end
  end

  describe "delete comment" do
    let(:params) do {
      comment_id: @comment,
      account_id: account.id,
      token: @token
    }
    end

    it "When comment is successfully delete" do
      delete :destroy, params: params
      expect(JSON.parse(response.body)["message"]).to eq("comment deleted succesfully!")
    end

    it 'When comment is not deleted' do
      allow(BxBlockComments::Comment).to receive(:find_by).and_return(@comment)
      allow(@comment).to receive(:destroy).and_return(false)
      delete :destroy, params: params
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to eq("comment is not deleted")
    end
  end

  describe "get_comments_on_a_post" do
    let(:params) do
      {
        commentable_id: @post.id,
        commentable_type: "BxBlockPosts::Post",
        token: @token
      }
    end

    it "returns comments when present on a post" do
      get :get_comments_on_a_post, params: params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']).to be_an_instance_of(Array)
      expect(JSON.parse(response.body)['data'].first['type']).to eq('comment')
    end

    it "returns 'No comments.' when comments are not present on the post" do
      @comment.destroy
      get :get_comments_on_a_post, params: params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['errors'].first['message']).to eq("No comments.")
    end
  end
end