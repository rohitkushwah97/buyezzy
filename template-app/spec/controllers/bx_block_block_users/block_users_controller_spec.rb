require 'rails_helper' 

RSpec.describe BxBlockBlockUsers::BlockUsersController, type: :request do
	let!(:current_user) { FactoryBot.create(:account, activated: true) }
	let!(:another_user) { FactoryBot.create(:business_user) }
	let!(:user) { FactoryBot.create(:account) }

	let(:url) { "/bx_block_block_users/block_users" }

	let(:token) do
		BuilderJsonWebToken::JsonWebToken.encode(current_user.id)
	end

	let(:headers) do
	    { 'token' => "#{token}" }
	  end

	before do
		allow(controller).to receive(:current_user).and_return(current_user)
	end

	describe 'GET #index' do
    context 'when there are blocked users ' do
      before { create(:block_user, current_user_id: current_user.id, account_id: another_user.id) }

      it 'returns the list of blocked users' do
        get url, params: { token: token, page: 1, per_page: 1}
        expect(JSON.parse(response.body)["meta"]["message"]).to eq("List of blocked users.")
      end
    end

    context 'when there are no blocked users ' do
      it 'returns a message that no user are blocked' do
        get url, params: { token: token }
        expect(JSON.parse(response.body)["errors"].first["message"]).to eq("No user blocked.")
      end
    end
	end


	describe 'POST #create' do
		context 'when trying to blocked self' do
			it 'return error' do
				post url, params: { data: { attributes: { account_id: current_user.id }}, token: token }
        expect(JSON.parse(response.body)["errors"].first["message"]).to eq("You cannot block yourself.")
			end
		end

		context 'when blocking a valid user' do
			it 'blocks the user' do
				post url, params: { data: { attributes: { account_id: another_user.id  }}, token: token }
				expect(JSON.parse(response.body)['meta']['message']).to eq('User blocked.')
			end
		end

    context 'when account not found' do
      it 'return the not found error' do
        post url, params: { data: { attributes: { account_id: nil }}, token: token }
        expect(JSON.parse(response.body)["errors"].first["message"]).to eq("User does not exist.")
      end
    end

		context 'when user already blocked' do
	      before { create(:block_user, current_user_id: current_user.id, account_id: another_user.id) }

	      it 'returns already blocked error' do
	        post url, params: {
	          data: { attributes: { account_id: another_user.id } }, token: token
	        }
	        expect(JSON.parse(response.body)['errors'].first['message']).to eq('User already blocked.')
	      end
    	end
	end

  describe 'DELETE #destroy' do 
    context 'when unblock the user ' do
      let(:block_user) { create(:block_user, current_user_id: current_user.id, account_id: another_user.id)}

      it 'returns the user unblocked message' do
        delete "#{url}/#{block_user.id}", params: { id: block_user.id, token: token }     
        expect(JSON.parse(response.body)['message']).to eq('User unblocked.')
      end
    end

    context 'when user does not unblock ' do
      it 'return error an user not unblock message' do
         block_user = create(:block_user, current_user_id: current_user.id, account_id: another_user.id)
        # Simulate failure of destroy
        allow_any_instance_of(BxBlockBlockUsers::BlockUser).to receive(:destroy).and_return(false)
        delete "#{url}/#{block_user.id}", params: { token: token }
        expect(JSON.parse(response.body)['errors'].first['message']).to eq("User not unblock.")
      end
    end
  end
end