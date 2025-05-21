ActiveAdmin.register Threshold do
  actions :index, :show, :edit, :update

  permit_params :threshold_percentage
  remove_filter :threshold_percentage, :created_at, :updated_at
end