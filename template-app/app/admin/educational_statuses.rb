# frozen_string_literal: true

ActiveAdmin.register BxBlockProfile::EducationalStatus, as: "EducationalStatus" do
  menu label: 'Educational Status', parent: 'Drop Downs', priority: 1
  actions :index, :edit, :update, :show
	permit_params  :name
  remove_filter :schools, :universities, :code

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
