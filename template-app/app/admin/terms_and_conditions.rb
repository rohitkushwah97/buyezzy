# frozen_string_literal: true

ActiveAdmin.register BxBlockTermsAndConditions::TermsAndCondition, as: "Terms And Conditions" do
  menu label: 'Terms And Conditions', parent: 'Settings', priority: 1
  actions :index, :edit, :update,:show
	permit_params :account_type, :description
  remove_filter :user_terms_and_conditions, :description, :account_type, :created_at, :updated_at

  form do |f|
    f.inputs do
      f.input :description, as: :quill_editor
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :account_type
    actions
  end
end
