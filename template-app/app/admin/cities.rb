# frozen_string_literal: true

ActiveAdmin.register AccountBlock::City, as: "City" do
  menu label: 'Cities', parent: 'Drop Downs', priority: 4
	permit_params :name, :country_id

  form do |f|
    f.inputs do
      f.input :country, as: :select, collection: AccountBlock::Country.all, include_blank: false
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
