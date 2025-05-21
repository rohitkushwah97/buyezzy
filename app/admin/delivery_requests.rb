ActiveAdmin.register BxBlockOrderManagement::DeliveryRequest, as: 'Delivery Requests' do
  menu if: proc { false }
	permit_params :warehouse_id, :warehouse_name, :seller_id, :order_id, :order_number, :address_1, :address_2, :status

  filter :warehouse_id, as: :select, collection: proc { BxBlockCatalogue::Warehouse.pluck(:warehouse_name, :id) }
  filter :seller_id, as: :select, collection: proc { AccountBlock::Account.where(user_type: 'seller').pluck(:full_name, :id) }
  filter :warehouse_name
  filter :order_number
  filter :status, as: :select, collection: [['Pending','pending'], ['Accepted','accepted'], ['Rejected','rejected']]
  filter :created_at
  filter :updated_at

	index do
		selectable_column
		column :id
		column :warehouse
		column :warehouse_name
		column :order_number
		column "Seller", :seller do |obj|
				if obj.seller.present?
					link_to(obj.seller&.full_name, admin_seller_account_path(obj.seller_id))
				end
			end
		column :status
		actions
	end

  form do |f|
  	f.semantic_errors
    f.inputs 'Delivery Request Details' do
      f.input :seller_id, as: :select, collection: AccountBlock::Account.where(user_type: 'seller').pluck(:full_name, :id)
      f.input :warehouse_name, as: :select, collection: BxBlockCatalogue::Warehouse.pluck(:warehouse_name)
      f.input :order_number, as: :string
      f.input :address_1
      f.input :address_2
      f.input :status, as: :select, collection: [['Pending','pending'], ['Accepted','accepted'], ['Rejected','rejected']]
    end
    f.actions
  end


  controller do
  	before_action :fetch_order, only: [:create, :update]

  	private

  	def fetch_order
  		if params[:id] || params['delivery_request']['order_number']
  			order_number = params['delivery_request']['order_number']
  			warehouse_name = params['delivery_request']['warehouse_name']
  			order = BxBlockShoppingCart::Order.find_by(order_number: order_number)
  			warehouse = BxBlockCatalogue::Warehouse.find_by(warehouse_name: warehouse_name)
  			if order && warehouse
  				params['delivery_request']['order_id'] = order.id
  				params['delivery_request']['warehouse_id'] = warehouse.id
  			end
  		end
  	end
  end

end