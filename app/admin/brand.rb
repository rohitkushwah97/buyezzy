ActiveAdmin.register BxBlockCatalogue::Brand, as: 'Brands' do
	menu parent: 'Brands'
	permit_params :brand_name, :brand_name_arabic, :brand_year, :brand_website, :approve, :restricted, :gated, :branding_tradmark_certificate, :brand_image, :account_id

	filter :account_id, as: :select, collection: proc { AccountBlock::Account.seller_accounts.map { |obj| [obj.first_name, obj.id] } }, label: "Seller"
	filter :brand_name
	filter :brand_year
	filter :brand_website
	filter :approve
	filter :restricted

	filter :created_at, as: :date_range
	filter :updated_at, as: :date_range

	show do
		attributes_table do
			row "Seller", :account_id do |obj|
				if obj.account_id.present?
					link_to(obj&.account&.full_name, admin_seller_account_path(obj.account_id))
				end
			end
			row :brand_name
			row :brand_year
			row :brand_website
			row :brand_image do |brand|
				image_tag(brand.brand_image, size: '100x100') if brand.brand_image.attached?
			end
			row :branding_tradmark_certificate do |brand|
				if brand.branding_tradmark_certificate.attached?
					link_to(brand.branding_tradmark_certificate.filename, url_for(brand.branding_tradmark_certificate), target: '_blank')
				end
			end
			row :approve
			row :restricted
			row :created_at
			row :updated_at
		end
	end

	index do
		selectable_column
		id_column
		column :brand_name
		column :brand_year
		column :approve
		column :restricted
		column :created_at
		column :updated_at
		actions
	end

	form do |f|
		f.inputs 'Brand Details' do
			f.input :account_id, label: 'Seller', as: :select, collection: AccountBlock::Account.seller_accounts.map { |obj| ["#{obj&.full_name}", obj.id] }
			f.input :brand_name
			if f.object.brand_image.attached?
				f.input :brand_image, as: :file, hint: image_tag(url_for(f.object.brand_image), size: '100x100')
			else
				f.input :brand_image, as: :file
			end
			f.input :brand_year
			f.input :brand_website
			if f.object.branding_tradmark_certificate.attached?
				f.input :branding_tradmark_certificate, as: :file, hint: link_to(f.object.branding_tradmark_certificate.filename, url_for(f.object.branding_tradmark_certificate), target: '_blank')
			else
				f.input :branding_tradmark_certificate, as: :file
			end
			f.input :approve
			f.input :restricted
		end
		f.actions
	end

	controller do
		def destroy
			@brand = BxBlockCatalogue::Brand.find(params[:id])
			begin
				if @brand.destroy
					redirect_to admin_brands_path, notice: 'Brand deleted successfully.'
				end
			rescue => e
				redirect_to admin_brands_path, alert: @brand.errors.full_messages.join(", ")
			end
		end
	end

end
