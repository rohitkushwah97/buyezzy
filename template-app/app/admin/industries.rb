# frozen_string_literal: true

ActiveAdmin.register BxBlockCategories::Industry, as: "Industries" do
  menu label: 'Industries', parent: 'Categories/subcategories', priority: 2
	permit_params :name
  remove_filter :career_interests
  
  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  controller do
    def create
      if BxBlockCategories::Industry.all.count >= 20
        flash[:message] = "Cannot add more than 20 industries"
        redirect_to new_admin_industry_path
      else
        super
      end  
    end

    before_action :check_active_internship , only: [:destroy]

    def check_active_internship
      if BxBlockNavmenu::Internship.where("industry_id=? AND status=?",params[:id],1).exists?
        flash[:error] = "Industry cannot be deleted because it has active internships"
        redirect_to admin_industries_path
      end
    end
  end

  batch_action :destroy, confirm: "Are you sure you want to delete these industries?" do |selected_ids|
    industries = BxBlockCategories::Industry.where(id: selected_ids)
    not_deleted_industries = []

    industries.each do |industry|
      if BxBlockNavmenu::Internship.where("industry_id=? AND status=?",industry,1).exists?
        not_deleted_industries << industry.name 
      else
        industry.destroy
      end
    end

    if not_deleted_industries.any?
      flash[:error] = "The following industry were not deleted because they have active internships: #{not_deleted_industries.join(', ')}"
    else
      flash[:notice] = "Selected industry were successfully deleted."
    end

    redirect_to admin_industries_path
  end
end
