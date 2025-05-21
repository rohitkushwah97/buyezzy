ActiveAdmin.register BxBlockDashboard::Banner, as: "Top Banner" do
  menu parent: 'Home Page'

  permit_params :title, :button_text, :button_link, :banner_type, :status

  actions :index, :show, :edit, :update

  filter :title
  filter :button_text
  filter :button_link
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range


  index do
    selectable_column
    id_column
    column :title do |banner|
      truncate(banner.title, length: 30)
    end
    column :button_text do |banner|
      truncate(banner.button_text, length: 30)
    end
    column :button_link do |banner|
      truncate(banner.button_link, length: 30)
    end
    column :status
    actions
  end


  form do |f|
    f.semantic_errors *f.object.errors.keys, class: 'inline-errors'
    f.inputs 'Top Banner Details' do
      f.input :banner_type, as: :hidden, input_html: { value: "top_banner" }
      f.input :title
      f.input :button_text
      f.input :button_link
      f.input :status
    end
    f.actions
  end

  show do
    attributes_table do
      row :title 
      row :button_text
      row :button_link
      row :status
    end
  end

end
