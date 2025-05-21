ActiveAdmin.register BxBlockShoppingCart::Order, as: 'Order' do
  menu label: 'Orders'

  actions :index, :show, :edit, :update

  permit_params :order_status_id, :accepted

  filter :order_number
  filter :total_items
  filter :order_status
  filter :order_items_order_status_id_in, as: :select, label: 'Order Item Status', collection: -> {BxBlockOrderManagement::OrderStatus.pluck(:status, :id)} 
  filter :order_placed_at
  filter :delivered_at
  filter :accepted

  filter :customer, collection: -> { AccountBlock::Account.all.map { |account| [account.full_name, account.id] } }
  # filter :coupon_code, collection: -> { BxBlockCouponCg::CouponCode.all.map { |coupon| [coupon.code, coupon.id] } }
  filter :total_fees
  filter :total_tax
  filter :final_price
  filter :discount

  filter :order_items_catalogue_id_in, as: :select, collection: -> { BxBlockCatalogue::Catalogue.all.map { |catalogue| [catalogue&.product_content&.product_title, catalogue&.id] } },
  label: 'Catalogue'

  index do
    column :order_number
    column :total_items
    column :order_status
    column :order_placed_at
    column :delivered_at
    column :accepted
    actions
  end

  show do
    attributes_table do
      row :order_number
      row :total_fees
      row :total_items
      row :discount
      row :total_tax
      row :final_price
      row :transaction_id
      row :order_status
      row :order_placed_at
      row :delivered_at
      row :accepted
      row :customer do |order|
        if order.customer.present?
          link_to order.customer.full_name, admin_buyer_account_path(order.customer)
        end
      end
      row :sellers do |order|
        if order.sellers.present?
          order.sellers.uniq.map do |seller|
            link_to seller.full_name, admin_seller_account_path(seller)
          end.join(', ').html_safe
        end
      end
      row 'Shipping Address' do |order|
        if order.shipping_address.present?
          order.shipping_address.attributes.slice(
            'first_name', 'last_name', 'address_1', 'address_2',
            'phone_number', 'state', 'city', 'zip_code', 'address_type'
            ).values.join(', ')
        end
      end
      # row :coupon_code do |order|
      #   if order.coupon_code.present?
      #     link_to order.coupon_code.code, admin_coupon_path(order.coupon_code)
      #   end
      # end
    end

    panel 'Order Items' do
      table_for order.order_items do
        column('ID') { |order_item| link_to order_item.id, admin_order_item_path(order_item) }
        column :quantity
        column :price
        column 'Catalogue' do |order_item|
          catalogue = order_item.catalogue
          if catalogue.is_a?(BxBlockCatalogue::Catalogue)
            link_to catalogue&.product_content&.product_title, admin_product_path(catalogue)
          end
        end
        column :order_status
        column 'Actions' do |order_item|
          link_to 'View', admin_order_item_path(order_item)
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys, class: 'inline-errors' 
    f.inputs 'Order Details' do
      f.input :order_status
      f.input :accepted
    end
    f.actions
  end
end