ActiveAdmin.register BxBlockShoppingCart::OrderItem, as: 'OrderItem' do
  menu if: proc { false }

  actions :index, :show

  show do
    attributes_table do
      row :id
      row :order_id
      row :quantity
      row :price
      row :taxable
      row :taxable_value
      row :order_status
      row 'Catalogue' do |order_item|
        panel "Catalogue Details" do
          attributes_table_for order_item.catalogue do
            row('ID') { |catalogue| link_to catalogue.id, admin_product_path(catalogue) }
            row :sku
            row :besku
            row :product_title do |catalogue|
              catalogue.product_content&.product_title
            end
          end
        end
      end
      # row 'Favourite' do |order_item|
      #   favourite = BxBlockShoppingCart::OrderItem.get_favourites(order_item)
      #   status_tag(favourite, label: favourite ? 'Yes' : 'No')
      # end
    end
  end
end
