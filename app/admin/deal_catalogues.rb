ActiveAdmin.register BxBlockCatalogue::DealCatalogue, as: 'Seller Deals' do

	permit_params :status, :deal_price, :deal_id, :catalogue_id, :seller_id

	filter :deal, collection: proc { BxBlockCatalogue::Deal.pluck(:deal_name, :id) }, label: 'Deal Name'
	filter :catalogue_sku, as: :string, label: 'Catalogue SKU', filters: [:contains]
	filter :status, as: :select, collection: { "Review" => 0, "Approved" => 1, "Rejected" => 2, "Expired" => 3 }
	filter :seller, as: :select, collection: proc { AccountBlock::Account.all.where(user_type: 'seller').map { |seller| [seller.full_name, seller.id] } }
	filter :deal_price
	filter :created_at, as: :date_range
	filter :updated_at, as: :date_range

	index do
		selectable_column
		id_column
		column 'Deal', sortable: :deal_id do |deal_catalogue|
			deal_catalogue.deal.deal_name 
		end
		column 'Catalogue', sortable: :catalogue_id do |deal_catalogue|
			deal_catalogue.catalogue.is_variant ? deal_catalogue.catalogue&.product_variant_group&.product_sku : deal_catalogue.catalogue.sku
		end
		column 'Discount Type' do |deal_catalogue|
			deal_catalogue.deal.discount_type
		end
		column :deal_price
		column :current_offer_price
		column :status
		actions
	end

	show do
		attributes_table do
			row :id
			row :deal do |deal_catalogue|
				
				link_to deal_catalogue.deal.deal_name, admin_deal_path(deal_catalogue.deal)
			end
			row 'Catalogue' do |deal_catalogue|
				link_to (deal_catalogue.catalogue.is_variant ? deal_catalogue.catalogue&.product_variant_group&.product_sku : deal_catalogue.catalogue.sku), admin_product_path(deal_catalogue.catalogue)
			end
			row :seller
			row :product_title
			row :seller_price
			row :current_offer_price
			row :deal_price
			row :status
			row :created_at
			row :updated_at
		end
	end

	form do |f|
		f.semantic_errors
		f.inputs 'Seller Deal Details' do
			selected_seller_id = params[:seller_id].presence || f.object.seller_id
			f.input :seller, as: :select, collection: AccountBlock::Account.where(user_type: 'seller').all.map { |c| [c.full_name , c.id] }, selected: selected_seller_id
			f.input :deal, as: :select, collection: BxBlockCatalogue::Deal.active_deals.pluck(:deal_name, :id)
			selected_catalogue_id = params[:catalogue_id].presence || f.object.catalogue_id
			f.input :catalogue, as: :select, collection: BxBlockCatalogue::Catalogue.all.map { |c| 
              if c.is_variant
                ["#{c.sku} >> #{c.product_variant_group&.product_sku}", c.id]
              else
                [c.sku, c.id]
              end
            }, selected: selected_catalogue_id
			f.input :deal_price
			f.input :status
		end
		f.actions
	end

	controller do
		before_action :store_referer, only: [:edit]

		def store_referer
			session.delete(:previous_page) if session[:previous_page].present?
			session[:previous_page] = request.referer || request.fullpath
		end

		def update
		  deal_catalogue_params = params.require(:deal_catalogue).permit(:status, :seller_id, :deal_id, :deal_price)
		  is_approved = deal_catalogue_params[:status] == 'approved'
		  redirect_path = session[:previous_page] || admin_deal_path(resource.deal)

		  if is_approved
		    resource.update_columns(deal_catalogue_params.to_h)
		    redirect_to redirect_path
		  else
		    update! do |success, failure|
		      success.html { redirect_to redirect_path }
		      failure.html { render edit_admin_seller_deal_path(resource) }
		    end
		  end
		end
	end
end
