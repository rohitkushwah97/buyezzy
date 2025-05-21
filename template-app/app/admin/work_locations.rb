# frozen_string_literal: true
ActiveAdmin.register BxBlockSettings::WorkLocation, as: "Work Location" do
  menu label: 'Work Locations', parent: 'Drop Downs', priority: 3
	permit_params :name
  remove_filter :icon_attachment, :icon_blob, :code
  actions :edit, :update, :index, :show
  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row 'Icon' do |obj|
      if obj.icon.attached?
        image_tag url_for(obj.icon), size: "25x25"
      else
        "N/A"
      end
    end
      row :created_at
      row :updated_at
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column 'Icon' do |obj|
      if obj.icon.attached?
        image_tag url_for(obj.icon), size: "25x25"
      else
        "N/A"
      end
    end
    column :created_at
    column :updated_at
    actions
  end
end
