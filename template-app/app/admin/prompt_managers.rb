ActiveAdmin.register BxBlockChat::PromptManager, as: 'PromptManager' do
  permit_params :criteria
  actions :all, except: [:new, :destroy]
  menu false
  index do
    selectable_column
    id_column
    column 'Description', :criteria
    actions
  end

  show do |obj|
    attributes_table do
      row 'Description' do |obj|
        obj.criteria
      end
      div class: 'panel', label: "Prompt Versions" do
        ul do
          obj.prompt_versions.each do |version|
            li do
              link_to version.name, admin_prompt_version_path(version.id)
            end
          end
        end
      end
    end
  end

  controller do
    def update
        version = resource.prompt_versions.create!(name: "Prompt Version #{resource.prompt_versions.count + 1}", description: params['prompt_manager']['criteria'])
        resource.update(criteria: params['prompt_manager']['criteria'])
        redirect_to admin_prompt_manager_path(resource.id)
    end
  end

end
