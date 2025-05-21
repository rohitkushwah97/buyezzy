require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do
  render_views

  before(:each) do
    admin = FactoryBot.create(:admin)
    sign_in admin
  end

  let!(:account) { FactoryBot.create(:account, full_name: "Test User") }
  let!(:post) { FactoryBot.create(:post, account_id: account.id, name: "Sample Post") }

  describe "Posts #index" do
    context "GET index" do 
      it "should have http success for index" do 
        get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end

  describe "Posts #show" do
    context "GET show" do
      it "should return http success and display the post" do
        get :show, params: { id: post.id }
        expect(response).to have_http_status(200)
        expect(response.body).to include("Sample Post")
        expect(response.body).to include("Test User") # Ensure full_name is displayed
      end

      it "should return 404 for non-existing post" do
        expect {
          get :show, params: { id: 99999 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "Posts #destroy" do
    context "DELETE destroy" do
      it "should delete the post and redirect to index" do
        expect {
          delete :destroy, params: { id: post.id }
        }.to change(BxBlockPosts::Post, :count).by(-1)

        expect(response).to have_http_status(302) # Redirect
        expect(response).to redirect_to(admin_posts_path)
      end

      it "should return 404 when trying to delete a non-existing post" do
        expect {
          delete :destroy, params: { id: 99999 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
