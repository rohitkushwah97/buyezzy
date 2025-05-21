ActiveAdmin.register BxBlockCatalogue::Review, as: 'Reviews' do
  permit_params :rating, :title, :description, :catalogue_id, :is_approved, :order_item_id, :reviewer_id, :account_id, :review_type
  scope :product_feedbacks do
    BxBlockCatalogue::Review.where(review_type: "product").order(id: :desc)
  end

  scope :seller_feedbacks do
    BxBlockCatalogue::Review.where(review_type: "seller").order(id: :desc)
  end

  scope :delivery_feedbacks do
    BxBlockCatalogue::Review.where(review_type: "delivery").order(id: :desc)
  end

  filter :title
  filter :description
  filter :rating
  filter :review_type, :as => :select, :collection => ['product', 'seller', 'delivery']
  filter :account_id, as: :select, collection: proc { AccountBlock::Account.seller_accounts.map { |obj| [obj.first_name, obj.id] } }, label: "Sellers"
  filter :reviewer_id, as: :select, collection: proc { AccountBlock::Account.buyer_accounts.map { |obj| [obj.first_name, obj.id] } }, label: "Reviewers"
  filter :catalogue_id, as: :select, collection: proc { BxBlockCatalogue::Catalogue.all.map { |obj| [obj.product_title, obj.id] } }, label: "Products"

  csv do
    column :id
    column :title
    column :description
    column :rating
    column :catalogue_id do |obj|
      obj&.catalogue&.product_title
    end
    column :account_id do |obj|
      seller = AccountBlock::Account.seller_accounts.find_by(id: obj.account_id)
      seller&.first_name
    end
    column :reviewer_id do |obj|
      obj&.account&.first_name
    end
    column :review_type
    column :created_at
    column :updated_at
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title, label: "Title"
      f.input :description, label: "Description", as: :text, input_html: { rows: 5 }
      f.input :rating, hint: "rating should be between 1 and 5", input_html: { min: 1, max: 5, type: 'float', class: 'required numeric-input', step: 1 }
      f.input :review_images, as: :file, input_html: { multiple: true }
      if f.object.review_images.present?
        div style: 'display: flex; flex-wrap: wrap;' do
          f.object.review_images.each do |image|
            span style: 'margin: 5px;' do
              image_tag(image, size: '100x100')
            end
          end
        end
      end
      f.input :order_item_id, label: 'Order Item', as: :select, collection: BxBlockShoppingCart::OrderItem.all.map { |obj| [obj.catalogue&.product_title, obj.id] }
      f.input :catalogue_id, label: 'Products', as: :select, collection: BxBlockCatalogue::Catalogue.all.map { |obj| ["#{obj.product_title}", obj.id] }
      f.input :reviewer_id, label: 'Reviewers', as: :select, collection: AccountBlock::Account.buyer_accounts.map { |obj| ["#{obj&.full_name}", obj.id] }
      f.input :account_id, label: 'Sellers', as: :select, collection: AccountBlock::Account.seller_accounts.map { |obj| ["#{obj&.full_name}", obj.id] }
      f.input :review_type, label: 'Review Type', as: :select, collection: ['product', 'seller', 'delivery']
      f.input :is_approved
    end
    f.actions
  end

  index do
    selectable_column
    column "Products", :catalogue_id do |obj|
      link_to(obj&.catalogue&.product_title, admin_product_path(obj&.catalogue_id))
    end
    column :rating
    column :review_type
    column "Title", :title
    column "Reviewers", :reviewer_id do |obj|
      link_to(obj&.account&.first_name, admin_buyer_account_path(obj&.reviewer_id))
    end
    column "Sellers", :account_id do |obj|
      seller = AccountBlock::Account.seller_accounts.find_by(id: obj.account_id)
      if seller.present?
        link_to(seller&.first_name, admin_seller_account_path(seller.id))
      else
        "No seller added"
      end
    end
    column :created_at
    column :updated_at
     toggle_bool_column "Approved", :is_approved
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :rating
      row :review_type
      row "Products", :catalogue_id do |obj|
        link_to(obj&.catalogue&.product_title, admin_product_path(obj&.catalogue_id))
      end
      row "Order Item", :order_item_id do |obj|
          link_to(obj&.order_item&.id, admin_order_item_path(obj&.order_item)) if obj&.order_item.present?
      end
      row "Reviewers", :reviewer_id do |obj|
        link_to(obj&.account&.first_name, admin_buyer_account_path(obj&.reviewer_id))
      end
      row "Sellers", :account_id do |obj|
        seller = AccountBlock::Account.seller_accounts.find_by(id: obj.account_id)
        if seller.present?
          link_to(seller&.first_name, admin_seller_account_path(seller.id))
        else
          "No seller added"
        end
      end
      row :review_images do |review|
        div style: 'display: flex; flex-wrap: wrap;' do
          review.review_images.each do |image|
            span style: 'margin: 5px;' do
              link_to(image_tag(image, size: '100x100'), url_for(image), target: '_blank')
            end
          end
        end
      end
      row :is_approved
      row :created_at
      row :updated_at
    end
  end
end
