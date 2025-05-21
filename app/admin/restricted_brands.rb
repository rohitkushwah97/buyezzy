ActiveAdmin.register BxBlockCatalogue::RestrictedBrand, as: 'Restricted Brand Requests' do
	permit_params :brand_id, :approved, :reseller_permit_document, :seller_id

	menu parent: 'Brands'

	filter :brand, collection: -> { BxBlockCatalogue::Brand.all.map { |brand| [brand.brand_name, brand.id] } }, as: :select
	filter :seller_id, as: :select, collection: proc { AccountBlock::Account.seller_accounts.map { |obj| [obj.full_name, obj.id] } }, label: "Sellers"
	filter :approved, as: :select, collection: [['Yes', true], ['No', false]]

	index do
		selectable_column
		id_column
		column :brand
		column :approved
		column :reseller_permit_document do |brand|
			link_to('Download Document', url_for(brand.reseller_permit_document), target: '_blank') if brand.reseller_permit_document.present?
		end
		actions
	end

	show do
		attributes_table do
			row :brand
			row "Sellers", :seller_id do |obj|
				if obj.seller_id.present?
					link_to(obj&.seller&.full_name, admin_seller_account_path(obj.seller_id))
				end
			end
			row :approved
			row :reseller_permit_document do |brand|
				link_to('Download Document', url_for(brand.reseller_permit_document), target: '_blank') if brand.reseller_permit_document.present?
			end
		end
	end

	form do |f|
		f.inputs 'Restricted Brand Details' do
			f.input :brand, collection: BxBlockCatalogue::Brand.all.where(restricted: true).map { |brand| [brand.brand_name, brand.id] }, prompt: 'Select Brand'
			f.input :seller_id, label: 'Sellers', as: :select, collection: AccountBlock::Account.seller_accounts.map { |obj| ["#{obj&.full_name}", obj.id] }
			f.input :reseller_permit_document, as: :file
			f.input :approved
		end
		f.actions
	end

end