# frozen_string_literal: true

ActiveAdmin.register BxBlockProfile::School, as: "School" do
  menu label: 'Schools', parent: 'Drop Downs', priority: 3
	permit_params :name
  remove_filter :educational_status
  
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
    column 'Educational Status' do |obj|
      obj.educational_status.name
    end
    column :created_at
    column :updated_at
    actions
  end
end
