# frozen_string_literal: true

ActiveAdmin.register AccountBlock::Country, as: "Country" do
  menu label: 'Countries', parent: 'Drop Downs', priority: 4
	permit_params :name
  remove_filter :cities

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
    column :created_at
    column :updated_at
    actions
  end
end
