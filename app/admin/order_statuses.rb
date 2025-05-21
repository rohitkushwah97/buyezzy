ActiveAdmin.register BxBlockOrderManagement::OrderStatus, as: 'Order Status' do
  permit_params :name, :created_at, :updated_at
  

  filter :name
  filter :created_at, as: :date_range   
  filter :updated_at, as: :date_range       

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  show do
    attributes_table do
      row :name
      row :status
    end 
  end
  form do |f|
    f.inputs do
      f.input :name
    end
     f.actions
  end
end

