require 'rails_helper'

RSpec.describe Admin::IssueTypesController, type: :controller do
  render_views

  before(:each) do
    admin = FactoryBot.create(:admin)
    @issue_type = FactoryBot.create(:issue_type)
    sign_in admin
  end

  let(:valid_params) do
    {
      issue_type: {
        name: "issue1"
      }
    }
  end

  let(:update_params) do
    {
      id: @issue_type.id,
      issue_type: {
        name: "issue123"
      }
    }
  end

  describe 'Issue Type #index' do
    context 'Get Index' do
      it 'should have http status success for index' do
        get :index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
        expect(response.message).to eq('OK')

      end
    end
  end

  describe 'Issue Type #Show' do
    context 'Get Show' do
      it 'should have http status success for show' do
        get :show, params: { id: @issue_type.id }
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end

  describe 'Issue Type #delete' do
    context 'Delete' do
      it 'should have successfully deleted' do
        delete :destroy, params: { id: @issue_type.id }
        expect(flash[:notice]).to eq("Issue type was successfully destroyed.")
      end
    end
  end

  describe 'Issue Type #create' do
    it 'sets a flash[:notice] after #create' do
      post :create, params: valid_params
      expect(flash[:notice]).to eq("Issue type was successfully created.")
    end

    it 'creates a new issue type and redirects to the index page' do
      expect {
        post :create, params: valid_params
      }.to change(BxBlockHelpCentre::IssueType, :count).by(1)

      expect(response).to redirect_to(admin_issue_type_path(BxBlockHelpCentre::IssueType.last))
      expect(flash[:notice]).to eq("Issue type was successfully created.")
    end

    it 'renders the new template if creation fails' do
      post :create, params: { issue_type: { name: '' } }
      expect(response).to render_template(:new)
    end
  end

  describe 'Issue Type #update' do
    context 'Update' do
      it 'should have http status success for update' do
        patch :update, params: update_params
        expect(flash[:notice]).to eq("Issue type was successfully updated.")
        expect(response).to redirect_to(admin_issue_type_path(@issue_type))
      end

      it 'updates the issue type and redirects to the show page' do
        patch :update, params: update_params
        @issue_type.reload

        expect(@issue_type.name).to eq("issue123")
        expect(response).to redirect_to(admin_issue_type_path(@issue_type))
        expect(flash[:notice]).to eq("Issue type was successfully updated.")
      end

      it 'renders the edit template if update fails' do
        patch :update, params: { id: @issue_type.id, issue_type: { name: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end
end