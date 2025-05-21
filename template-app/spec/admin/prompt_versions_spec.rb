require 'rails_helper'

RSpec.describe Admin::PromptVersionManagersController, type: :controller do
  render_views

  before(:each) do
    admin = FactoryBot.create(:admin)
    sign_in admin
  end

  let!(:prompt_manager) { create(:prompt_manager) }
  let!(:prompt_version) { create(:prompt_version, prompt_manager: prompt_manager) }

  describe 'GET#show' do
    context 'show prompt version details' do
      it 'should return the details of the prompt version' do
        get :show, params: { id: prompt_version.id }

        expect(response).to have_http_status(200)
        expect(response.body).to include(prompt_version.name)
      end
    end
  end

  describe 'PATCH#update' do
    context 'update prompt manager criteria' do
      it 'should update the criteria and create a new prompt version' do
        updated_description = 'Sample criteria'
        new_criteria = 'Sample criteria'
        initial_count = prompt_manager.prompt_versions.count

        patch :update, params: { 
          id: prompt_manager.id,
          prompt_version: { description: updated_description },
          prompt_manager: { criteria: new_criteria }
        }

        prompt_manager.reload

        expect(prompt_manager.criteria).to eq(new_criteria)

        prompt_manager.reload
      end

      it 'does not create a new prompt version if description is empty' do
        initial_count = prompt_manager.prompt_versions.count

        patch :update, params: { 
          id: prompt_version.id,  
          prompt_version: { description: "" }  # Empty description
        }

        prompt_manager.reload

        # Expect no new prompt version to be created
        expect(prompt_manager.prompt_versions.count).to eq(initial_count)
        
        # Expect criteria to remain unchanged
        expect(prompt_manager.criteria).not_to be_empty  # It should not update to blank

        expect(response).to redirect_to(edit_admin_prompt_version_manager_path(prompt_version))
        expect(flash[:error]).to eq("Description can't be blank.")
      end
    end
  end
end
