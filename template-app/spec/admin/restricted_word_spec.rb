require 'rails_helper'

RSpec.describe Admin::RestrictedWordsController, type: :controller do
  render_views

  before(:each) do
    admin = FactoryBot.create(:admin)
    sign_in admin
  end

  let!(:restricted_word) { FactoryBot.create(:restricted_word, word: "testword") }
  let(:valid_params) do
    {
      restricted_word: {
        word: "newrestrictedword"
      }
    }
  end
  let(:update_params) do
    {
      id: restricted_word.id,
      restricted_word: {
        word: "updatedrestrictedword"
      }
    }
  end
  let(:invalid_params) do
    {
      restricted_word: {
        word: ""
      }
    }
  end

  describe "RestrictedWord #create" do
    it "sets flash[:notice] after creating a new restricted word" do
      post :create, params: valid_params
      expect(flash[:notice]).to eq("Restricted word was successfully created.")
    end

    it "does not create a restricted word with a blank word and sets flash[:alert]" do
      post :create, params: invalid_params
      expect(flash[:alert]).to eq("Word can't be blank")
    end
  end

  describe "RestrictedWord #index" do
    context "GET index" do
      it "should return http success and display the restricted words" do
        get :index
        expect(response).to have_http_status(200)
        expect(response.body).to include(restricted_word.word)
      end
    end
  end

  describe "RestrictedWord #edit" do
    context "GET edit" do
      it "should return http success and display the edit form" do
        get :edit, params: { id: restricted_word.id }
        expect(response).to have_http_status(200)
        expect(response.body).to include("Edit Restricted Word")
      end
    end
  end

  describe "RestrictedWord #update" do
    it "sets flash[:notice] after updating the restricted word" do
      patch :update, params: update_params
      expect(flash[:notice]).to eq("Restricted word was successfully updated.")
    end

    it "sets flash[:alert] if the update is invalid" do
      patch :update, params: { id: restricted_word.id, restricted_word: { word: "" } }
      expect(flash[:alert]).to eq("Word can't be blank")
    end
  end

  describe "RestrictedWord #destroy" do
    it "sets flash[:notice] after destroying a restricted word" do
      delete :destroy, params: { id: restricted_word.id }
      expect(flash[:notice]).to eq("Restricted word was successfully destroyed.")
    end
  end

  describe "RestrictedWord #batch_action" do
    it "deletes selected restricted words successfully" do
      post :batch_action, params: { collection_selection: [restricted_word.id], batch_action: 'destroy' }
      expect(flash[:notice]).to eq("Successfully deleted 1 restricted word")
    end
  end
end
