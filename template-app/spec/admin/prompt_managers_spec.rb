require 'rails_helper'

RSpec.describe Admin::PromptManagersController, type: :controller do
  render_views

  before(:each) do
    admin = FactoryBot.create(:admin)
    sign_in admin
  end

  let!(:prompt_manager)  { create(:prompt_manager) }

  describe 'GET#index' do
    context 'get all prompt managers' do
      it 'should return list of prompts' do
        get :index
        expect(response).to have_http_status(200)
        expect(response.message).to eql('OK')
        expect(response.body).to be_present
      end
    end
  end

  describe 'GET#show' do
    context 'show prompt manager details' do
      it 'should return the details of the prompt manager' do
        get :show, params: { id: prompt_manager.id }
        
        expect(response).to have_http_status(200)
        expect(response.body).to include(prompt_manager.criteria)
        prompt_manager.prompt_versions.each do |version|
          expect(response.body).to include(version.name)
        end
      end
    end
  end

  describe 'PATCH#update' do
    context 'update prompt manager criteria' do
      it 'should update the criteria and create a new prompt version' do
        new_criteria = 'Updated criteria'
        initial_count = prompt_manager.prompt_versions.count
        
        patch :update, params: { 
          id: prompt_manager.id,
          prompt_manager: { criteria: new_criteria }
        }

        prompt_manager.reload

        expect(prompt_manager.criteria).to eq(new_criteria)

        expect(prompt_manager.prompt_versions.count).to eq(initial_count + 1)

        expect(response).to redirect_to(admin_prompt_manager_path(prompt_manager))
      end
    end
  end



end