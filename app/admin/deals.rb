ActiveAdmin.register BxBlockCatalogue::Deal, as: 'Deals' do

  permit_params :deal_name,:deal_code,:start_date,:end_date,:status,:discount_type, :discount_value

  filter :deal_name
  filter :deal_code
  filter :discount_type
  filter :start_date
  filter :end_date
  filter :status
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range

  index do
    selectable_column
    id_column
    column :deal_name
    column :deal_code
    column :discount_type
    column :discount_value
    column :start_date
    column :end_date
    column :status
    actions
  end

  form do |f|
    f.inputs 'Deal Details' do
      f.input :deal_name
      f.input :deal_code
      f.input :discount_type, as: :select, collection: BxBlockCatalogue::Deal.discount_types.keys.map(&:to_s)
      f.input :discount_value
      f.input :start_date, as: :date_picker
      f.input :end_date, as: :date_picker
      f.input :status, as: :select, collection: [['Active', true], ['Inactive', false]]
    end
    f.actions
  end
  
  show do

    attributes_table do
      row :id
      row :deal_name
      row :deal_code
      row :discount_type
      row :discount_value
      row :start_date
      row :end_date
      row :status
    end
    
    if resource.deal_catalogues.present?
      panel 'Deal Catalogues' do
        table_for resource.deal_catalogues.order(created_at: :desc) do
          column :seller_sku do |deal_catalogue|
            deal_catalogue.catalogue.is_variant ? "#{deal_catalogue.catalogue.sku} >> #{deal_catalogue.catalogue&.product_variant_group&.product_sku}" : deal_catalogue.catalogue.sku
          end
          column :product_title
          column :seller_price
          column :current_offer_price
          column :deal_price
          column 'Status' do |deal_catalogue|
            deal_catalogue.status.capitalize
          end
          column 'Edit Status' do |deal_catalogue|
            link_to 'Edit', edit_admin_seller_deal_path(deal_catalogue)
          end
        end
      end
    end
  end

end
