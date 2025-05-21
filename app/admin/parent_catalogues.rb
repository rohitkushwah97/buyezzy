ActiveAdmin.register BxBlockCatalogue::ParentCatalogue, as: 'Byezzy Products' do
  permit_params :category_id, :brand_id, :sku, :besku, :prod_model_no, :details, :status, :product_title,
                :sub_category_id, :mini_category_id, :micro_category_id, :product_image

  # actions :index, :show, :edit, :update, :new, :create, :delete
  menu if: proc { false }

  index do
    selectable_column
    id_column
    column :category
    column :brand
    column :sku
    column :besku
    column :product_title
    column :prod_model_no
    column :details
    actions
  end

  filter :category
  filter :brand, as: :select, collection: proc { BxBlockCatalogue::Brand.pluck(:brand_name, :id) }
  filter :besku
  filter :status
  filter :product_title

  form do |f|
    f.inputs do
      f.input :category
      f.input :brand,  as: :select, collection: BxBlockCatalogue::Brand.pluck(:brand_name, :id)
      if f.object.new_record?
        f.input :besku, as: :string, input_html: { readonly: true, value: f.object&.generate_unique_besku }
      else
        f.input :besku, as: :string, input_html: { readonly: true }
      end
      f.input :product_title
      f.input :prod_model_no
      if f.object.product_image.attached?
        f.input :product_image, as: :file, hint: image_tag(url_for(f.object.product_image), size: '100x100')
      else
        f.input :product_image, as: :file
      end
      f.input :details
      f.input :status
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :category
      row :brand
      row :sku
      row :besku
      row :product_title
      row :product_image do |product|
        image_tag(product.product_image, size: '100x100') if product.product_image.attached?
      end
      row :prod_model_no
      row :details
      row :status
    end

    panel 'Catalogues' do
      table_for resource.catalogues do
        column('ID') { |catalogue| link_to catalogue.id, admin_product_path(catalogue) }
        column :sku
        column :besku
        column :product_title
        column :product_image do |catalogue|
          image_tag(catalogue.product_image, size: '50x50') if catalogue.product_image.attached?
        end
        column :seller do |catalogue|
          link_to catalogue.seller&.full_name, admin_seller_account_path(catalogue.seller) if catalogue.seller.present?
        end
      end
    end
  end

end
