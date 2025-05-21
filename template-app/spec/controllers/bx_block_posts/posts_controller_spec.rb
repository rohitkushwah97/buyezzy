require 'rails_helper'

RSpec.describe BxBlockPosts::PostsController, type: :controller do
  UPDATE_POST_BODY = "Updated Post Body"
  UPDATE_POST_NAME = "Updated Post Name"
  UPDATE_POST_DIS = "Updated Post Description"
  let!(:business_user) { create(:business_user, email: 'business@example.com', activated: true) }
  before do
    @token = BuilderJsonWebToken.encode(business_user.id)
  end

  let!(:image) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/images/part_time.png'), 'image/png') }
  let!(:image2) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/images/part_time.png'), 'image/png') }
  let!(:video) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/videos/sample.mp4'), 'video/mp4') }

  describe "create post" do
    let(:params) do
      {
        post: {
          body: "New Post",
          name: "post",
          description: "Description of the post 1",
          category_id: 1,
          sub_category_id: 1,
          location: "Some location4",
          account_id: business_user.id,
          images: [image]
        },
          token: @token
      }
    end

    let(:params_with_video) do
      {
        post: {
          body: "New Post with video",
          name: "post",
          description: "Description of the post 2",
          category_id: 1,
          sub_category_id: 1,
          location: "Some location3",
          account_id: business_user.id
        },
        images: [image, video],
        token: @token
      }
    end

    let(:params_more_than_4_images) do
      {
        post: {
          body: "New Post with many images",
          name: "post",
          description: "Description of the post 3",
          category_id: 1,
          sub_category_id: 1,
          location: "Some location3",
          account_id: business_user.id
        },
        images: [image, image, image, image, image],
        token: @token
      }
    end

    let(:params_more_than_1_video) do
      {
        post: {
          body: "New Post with multiple videos",
          name: "post",
          description: "Description of the post 4",
          category_id: 1,
          sub_category_id: 1,
          location: "Some location1",
          account_id: business_user.id
        },
        images: [video, video],
        token: @token
      }
    end

    it "should create a post successfully" do
      expect {
        post :create, params: params
      }.to change(BxBlockPosts::Post, :count).by(1)

      expect(response).to have_http_status(:ok)

      response_body = JSON.parse(response.body)
      post_id_from_response = response_body['data']['id'].to_i

      created_post = BxBlockPosts::Post.find(post_id_from_response)

      expect(post_id_from_response).to eq(created_post.id)
      expect(response_body['data']['type']).to eq("post")
    end

    it "should create if both images and videos are uploaded" do
      post :create, params: params_with_video
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['type']).to eq("post")
    end

    it "should return error if more than 4 images are uploaded" do
      post :create, params: params_more_than_4_images
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("You can only upload up to 4 images")
    end

    it "should return error if more than 1 video is uploaded" do
      post :create, params: params_more_than_1_video
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("You can only upload 1 video")
    end

    it "should return error when post is not created (unprocessable entity)" do
      allow_any_instance_of(BxBlockPosts::Post).to receive(:save).and_return(false)
      post :create, params: params
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['data']['type']).to eq("error")
    end
  end

  describe "PUT #update" do
    let!(:post) { create(:post, account_id: business_user.id) }
    let(:valid_update_params) do
      {
        id: post.id,
        post: {
          body: UPDATE_POST_BODY,
          name: UPDATE_POST_NAME,
          description: UPDATE_POST_DIS,
          category_id: 1,
          sub_category_id: 1,
          account_id: business_user.id
        },
        images: [image, image2],
        images_to_keep: post.images.map(&:id).first,
        token: @token
      }
    end

    let(:invalid_update_params) do
      {
        id: post.id,
        post: {
          body: "",
          name: UPDATE_POST_NAME,
          description: UPDATE_POST_DIS,
          category_id: 1,
          sub_category_id: 1,
          account_id: business_user.id
        },
        images: [image],
        token: @token
      }
    end

    let(:invalid_token_update_params) do
      {
        id: post.id,
        post: {
          body: UPDATE_POST_BODY,
          name: UPDATE_POST_NAME,
          description: UPDATE_POST_DIS,
          category_id: 1,
          sub_category_id: 1,
          account_id: business_user.id
        },
        images: [image],
        token: "invalidtoken"
      }
    end

    let(:update_with_images_and_video) do
      {
        id: post.id,
        post: {
          body: "Updated Post Body with video",
          name: "Updated Post Name with video",
          description: "Updated Post Description with video",
          category_id: 1,
          sub_category_id: 1,
          location: "Updated location with video",
          account_id: business_user.id
        },
        images: [image, video],
        token: @token
      }
    end

    it "should remove unlisted images and retain only images_to_keep during update" do
      post.images.attach([image, image2])
      image_ids = post.images.map(&:id)
      images_to_keep = [image_ids.first]

      put :update, params: {
        id: post.id,
        post: {
          body: "Post with pruned images",
          name: "Cleaned Post",
          description: "Should keep only one image",
          category_id: 1,
          sub_category_id: 1,
          account_id: business_user.id
        },
        images_to_keep: images_to_keep,
        token: @token
      }

      post.reload
      expect(post.images.count).to eq(1)
      expect(post.images.first.id).to eq(images_to_keep.first)
    end


    it "should successfully update a post with valid parameters" do
      put :update, params: valid_update_params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['attributes']['body']).to eq(UPDATE_POST_BODY)
    end

    it "should return error if required fields are missing during update" do
      put :update, params: invalid_update_params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['type']).to eq("post")
    end

    it "should return error if the user tries to update a post with an invalid token" do
      put :update, params: invalid_token_update_params
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)['errors'].any? { |error| error['token'] == "Invalid token" }).to be true
    end

    it "should update if both images and a video are uploaded during update" do
      put :update, params: update_with_images_and_video
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['attributes']['body']).to eq("Updated Post Body with video")
    end

    it "should return error if the post being updated is not found" do
      put :update, params: { id: 9999, post: valid_update_params[:post], token: @token }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors'].any? { |error| error['Post'] == "Not found" }).to be true
    end

    it "should return error if the user tries to update a post they don't own" do
      another_user = create(:business_user, email: 'another@example.com', activated: true)
      another_token = BuilderJsonWebToken.encode(another_user.id)
      put :update, params: valid_update_params.merge({ token: another_token })
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['errors'].any? { |error| error['Post'] == "Not found" }).to be true
    end

    it "should update the post successfully when only images are provided" do
      update_with_images_only = valid_update_params.clone
      update_with_images_only[:images] = [image]
      put :update, params: update_with_images_only
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['attributes']['body']).to eq(UPDATE_POST_BODY)
    end

    it "should update the post successfully when no images are provided" do
      update_without_images = valid_update_params.clone
      update_without_images.delete(:images)
      put :update, params: update_without_images
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['attributes']['body']).to eq(UPDATE_POST_BODY)
    end
  end

   describe "get #users_all_posts" do
    let!(:post) { create(:post, account_id: business_user.id) }
    let(:valid_params) do
      {
        id: post.id,
        post: {
          body: UPDATE_POST_BODY,
          name: UPDATE_POST_NAME,
          description: UPDATE_POST_DIS,
          category_id: 1,
          sub_category_id: 1,
          account_id: business_user.id
        },
        images: [image],
        user_id: business_user.id,
        token: @token
      }
    end

    it "current user all posts if posts present" do
      get :users_all_posts, params: valid_params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'][0]['attributes']['body']).to eq("New Post")
    end

    it "current user all posts if posts not present" do
      post.delete
      get :users_all_posts, params: valid_params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']).to eq([])
    end
  end

  describe "get #activity_feed_posts" do
    let!(:post) { create(:post, account_id: business_user.id) }
    let(:valid_params) do
      {
        id: post.id,
        post: {
          body: UPDATE_POST_BODY,
          name: UPDATE_POST_NAME,
          description: UPDATE_POST_DIS,
          category_id: 1,
          sub_category_id: 1,
          account_id: business_user.id
        },
        images: [image],
        token: @token
      }
    end

    it "activity feed posts if posts not present" do
      post.delete
      get :activity_feed_posts, params: valid_params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']).to eq([])
    end
  end
end
