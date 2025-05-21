# frozen_string_literal: true

ActiveAdmin.register BxBlockProfile::University, as: "University" do
  menu label: 'Universities', parent: 'Drop Downs', priority: 2
	permit_params :name, :educational_status_id
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
