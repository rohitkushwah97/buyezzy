ActiveAdmin.register BxBlockStoreManagement::Store, as: 'Stores' do
	permit_params :store_name, :store_year, :store_url, :website_social_url, :approve, :account_id

	filter :store_name
	filter :store_year
	filter :store_url
	filter :website_social_url
	filter :approve
	filter :account, label: 'Seller', as: :select, collection: proc { AccountBlock::Account.where(user_type: 'seller').pluck(:full_name, :id) }
	filter :brand, as: :select, collection: proc { BxBlockCatalogue::Brand.pluck(:brand_name, :id) }
	filter :created_at, as: :date_range
	filter :updated_at, as: :date_range

	index do
		selectable_column
		id_column
		column :store_name
		column :store_year
		column :store_url
		column :website_social_url
		column :approve
		actions
	end

	show do
		attributes_table do
			row :brand
			row :store_name
			row :store_year
			row :store_url
			row :website_social_url
			row :brand_trade_certificate do |store|
				if store.brand_trade_certificate.attached?
					link_to(store.brand_trade_certificate.filename, url_for(store.brand_trade_certificate), target: '_blank')
				end
			end
			row 'Seller' do |store|
				if store.account
					link_to store.account.full_name, admin_seller_account_path(store.account)
				end
			end
			row :approve
		end
	end

	form do |f|
		f.semantic_errors
		f.inputs do
			f.input :account,label: 'Seller', as: :select, collection: AccountBlock::Account.where(user_type: 'seller').pluck(:full_name, :id)
			f.input :brand, as: :select, collection: BxBlockCatalogue::Brand.pluck(:brand_name, :id)
			f.input :store_name
			f.input :store_year
			f.input :store_url
			f.input :website_social_url
			f.input :approve
		end
		f.actions
	end

end
