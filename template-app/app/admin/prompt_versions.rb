ActiveAdmin.register BxBlockChat::PromptVersion, as: 'Prompt Version Manager' do
  permit_params :id, :name, :description
  actions :all, except: [:destroy, :new]

  show do
    div do
      table do
        tr do
          td "ID"
          td "Name"
          td "Description"
        end
        tr do
          td resource.id
          td resource.name
          td resource.description
        end
      end
    end
  end

  form do |f|
    f.inputs "Edit Prompt Version" do
      f.input :description, label: "Description", required: true
    end
    f.actions
  end

  controller do
    def update
      manager = BxBlockChat::PromptManager.first
      description = params[:prompt_version][:description]

      if description.blank?
        flash[:error] = "Description cannot be empty."
      end

      prompt_version = manager.prompt_versions.create(name: "Prompt Version #{manager.prompt_versions.count + 1}", description: description)

      if prompt_version.persisted?
        manager.update(criteria: description)
        redirect_to admin_prompt_version_managers_path, notice: "Prompt Version updated successfully."
      else
        flash[:error] = "Description can't be blank."
        redirect_back(fallback_location: edit_admin_prompt_version_manager_path(params[:id]))
      end
    end
  end


end
