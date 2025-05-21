# frozen_string_literal: true

ActiveAdmin.register BxBlockProfile::AcademicLevel, as: "AcademicLevel" do
  menu label: 'Academic Level', parent: 'Drop Downs', priority: 2
	permit_params  :name

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :updated_at
    actions
  end
end
