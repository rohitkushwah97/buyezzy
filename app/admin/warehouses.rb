ActiveAdmin.register BxBlockCatalogue::Warehouse, as: 'Warehouse' do
menu if: proc { false }
  permit_params :warehouse_type, :warehouse_name, :warehouse_address_1, :warehouse_address_2, :contact_number, :contact_person, :processing_days, :account_id

  filter :account, label: 'Seller', as: :select, collection: proc { AccountBlock::Account.all.where(user_type: 'seller').map { |seller| [seller.full_name, seller.id] } }
  filter :warehouse_name
  filter :processing_days
  filter :contact_number
  filter :contact_person
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range

  index do
    selectable_column
    id_column
    column :warehouse_name
    column :processing_days
    actions
  end

  form do |f|
    f.inputs do
      selected_seller_id = params[:account_id].presence || f.object.account_id
      f.input :account_id, label: 'Seller', as: :select, collection: AccountBlock::Account.where(user_type: 'seller').all.map { |c| [c.full_name , c.id] }, selected: selected_seller_id
      f.input :warehouse_name
      f.input :warehouse_address_1
      f.input :warehouse_address_2
      f.input :processing_days
      f.input :contact_person
      f.input :contact_number
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row 'Seller' do |warehouse|
        link_to warehouse.account.full_name, admin_seller_account_path(warehouse.account)
      end
      row :warehouse_name
      row :warehouse_address_1
      row :warehouse_address_2
      row :processing_days
      row :contact_person
      row :contact_number
      row :created_at
      row :updated_at
    end

    panel 'Warehous Products' do
      table_for warehouse.warehouse_catalogues do
        column :catalogue
        column :stocks
      end
    end
  end
end
