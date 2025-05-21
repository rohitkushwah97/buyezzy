# frozen_string_literal: true
ActiveAdmin.register BxBlockSettings::WorkSchedule, as: "WorkSchedule" do
  menu label: 'Work Schedules', parent: 'Drop Downs', priority: 3
	permit_params :schedule
  remove_filter :icon_attachment, :icon_blob, :code
  actions :edit, :update, :index, :show
  form do |f|
    f.inputs do
      f.input :schedule
    end
    f.actions
  end

  show do
    attributes_table do
      row :schedule
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
    column :schedule
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
