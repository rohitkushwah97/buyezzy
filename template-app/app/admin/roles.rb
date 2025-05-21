# frozen_string_literal: true

ActiveAdmin.register BxBlockCategories::Role, as: "Roles" do
  menu label: 'Roles', parent: 'Categories/subcategories', priority: 2
	permit_params :name, :industry_id
  remove_filter :survey, :internships, :career_interests
  
  form do |f|
    f.inputs do
      f.input :industry_id, :as => :select, :collection => BxBlockCategories::Industry.all.collect {|industry| [industry.name, industry.id] }, include_blank: false
      f.input :name
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column 'Industry' do |obj|
      obj.industry.name
    end
    actions
  end

  controller do
    def create
      if BxBlockCategories::Role.where(industry_id: params["role"]["industry_id"]).all.count >= 20
        industry = BxBlockCategories::Industry.find_by(id: params["role"]["industry_id"])
        flash[:message] = "#{industry.name.titleize} can't have more than 20 roles."
        redirect_to new_admin_role_path
      else
        super
      end  
    end

    before_action :check_active_internship , only: [:destroy]

    def check_active_internship
      if BxBlockNavmenu::Internship.where("role_id=? AND status=?",params[:id],1).exists?
        flash[:error] = "Role cannot be deleted because it has active internships"
        redirect_to admin_roles_path
      end
    end
  end

  batch_action :destroy, confirm: "Are you sure you want to delete these roles?" do |selected_ids|
    roles = BxBlockCategories::Role.where(id: selected_ids)
    not_deleted_roles = []

    roles.each do |role|
      if role.internships.where("role_id=? AND status=?",role,1).exists?
        not_deleted_roles << role.name 
      else
        role.destroy
      end
    end

    if not_deleted_roles.any?
      flash[:error] = "The following roles were not deleted because they have active internships: #{not_deleted_roles.join(', ')}"
    else
      flash[:notice] = "Selected roles were successfully deleted."
    end

    redirect_to admin_roles_path
  end
end
