require 'rails_helper'
RSpec.describe BxBlockFavourites::FollowsController, type: :controller do
	USER_NOT_EXISTS = "User Doesn't Exists"
	let!(:business_user) { create(:business_user, email: 'business@example.com', activated: true) }
	let!(:business_user_2) { create(:business_user, email: 'business1@example.com', activated: true) }
	before do
	  @token = BuilderJsonWebToken.encode(business_user.id)
	end
	let(:follow) do
    	FactoryBot.create(:follow, account_id: business_user.id, follow_id: business_user_2.id)
  	end

	let(:body) { JSON.parse(response.body) }
	before do
		@token = BuilderJsonWebToken.encode business_user.id
	    @token1 = BuilderJsonWebToken.encode business_user_2.id
	    @token2 = BuilderJsonWebToken.encode(0)
	end
 	
	describe "#follow_user" do
		it 'follow user successfully' do
		 	post :create, params: { user_id: business_user_2.id, token: @token  }
		 	expect(JSON.parse(response.body)["message"]).to eq("Started Following")
		end
		it 'will return error message when user already following' do
			follow.reload
		 	post :create, params: { token: @token, user_id: business_user_2.id }
		 	expect(body["message"]).to eq("Already Following")
		end
		it 'will return error message when user not found' do
		 	post :create, params: { token: @token, user_id: (business_user_2.id)+1 }
		 	expect(body["error"]).to eq(USER_NOT_EXISTS)
		end
 	end
 	describe "#unfollow_user" do
		it 'will return error message when user not following' do
		 	delete :unfollow, params: { user_id: business_user.id, token: @token  }
		 	expect(JSON.parse(response.body)["message"]).to eq("Please Follow To Unfollow")
		end
		it 'unfollow user' do
			follow.reload
		 	delete :unfollow, params: { user_id: business_user_2.id, token: @token  }
		 	expect(body["message"]).to eq("Unfollowing")
		end
		it 'will return error message' do
		 	delete :unfollow, params: { user_id: (business_user_2.id)+1, token: @token  }
		 	expect(body["error"]).to eq(USER_NOT_EXISTS)
		end
 	end

 	describe "#remove_follower_from_followers" do
        let!(:follow) { create(:follow, account_id: business_user_2.id, follow_id: business_user.id) }

		it 'remove follower from followers list successfully' do
		 	delete :remove_follower_from_followers, params: { user_id: business_user_2.id, token: @token  }
		 	expect(JSON.parse(response.body)["message"]).to eq("follower remove from your account")
		end
		it 'follow record not present ' do
			follow.reload
		 	delete :remove_follower_from_followers, params: { user_id: business_user.id, token: @token  }
		 	expect(body["message"]).to eq("follow record not present")
		end
		it 'will return error message user do not exists ' do
		 	delete :remove_follower_from_followers, params: { user_id: (business_user_2.id)+1, token: @token  }
		 	expect(body["error"]).to eq(USER_NOT_EXISTS)
		end
 	end

 	describe "get #current_user_followings" do
        let!(:follow) { create(:follow, account_id: business_user.id, follow_id: business_user_2.id) }

	    it "current user all followings if present" do
	      get :current_user_followings, params: { token: @token }
	      expect(response).to have_http_status(:ok)
	      expect(JSON.parse(response.body)['data'].count).to eq(1)
	    end

	    it "current user if followings not present" do
	      follow.delete
	      get :current_user_followings, params: { token: @token }
	      expect(response).to have_http_status(:ok)
	      expect(JSON.parse(response.body)['data']).to eq([])
	    end
    end

    describe "get #current_user_followers" do
        let!(:follow) { create(:follow, account_id: business_user_2.id, follow_id: business_user.id) }

	    it "current user all followers if present" do
	      get :current_user_followers, params: { token: @token }
	      expect(response).to have_http_status(:ok)
	      expect(JSON.parse(response.body)['data'].count).to eq(1)
	    end

	    it "current user if followers not present" do
	      follow.delete
	      get :current_user_followers, params: { token: @token }
	      expect(response).to have_http_status(:ok)
	      expect(JSON.parse(response.body)['data']).to eq([])
	    end
    end
end