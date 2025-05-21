STATUS_OPTIONS = [['Approved', true], ['Not Approved', false]]

ActiveAdmin.register BxBlockCatalogue::Catalogue, as: 'Products' do

	permit_params :sku, :besku, :bibc, :product_title, :product_image, :status, :category_id, :brand_id, :sub_category_id, :mini_category_id, :micro_category_id, :seller_id, :fulfilled_type,:product_type, :content_status, :recommended_priority

	actions :new, :create, :index, :show, :edit, :update

	scope :all, default: true do |catalogues|
		catalogues.where.not(content_status: 'archived').order(created_at: :desc)
	end

	scope :archived do
		BxBlockCatalogue::Catalogue.where(content_status: "archived").order(updated_at: :desc)
	end

	filter :category, as: :select, collection: proc { BxBlockCategories::Category.all.pluck(:name, :id) }
	filter :brand_id, as: :select, collection: proc { BxBlockCatalogue::Brand.pluck(:brand_name, :id) }
	filter :sub_category, as: :select, collection: proc { BxBlockCategories::SubCategory.all.pluck(:name, :id) }
	filter :mini_category, as: :select, collection: proc { BxBlockCategories::MiniCategory.all.pluck(:name, :id) }
	filter :micro_category, as: :select, collection: proc { BxBlockCategories::MicroCategory.all.pluck(:name, :id) }
	filter :deal_catalogues, as: :select, collection: proc { BxBlockCatalogue::DealCatalogue.all.map { |dc| [dc.deal.deal_name, dc.id] } }
	filter :catalogue_offer, as: :select, collection: proc { BxBlockCatalogue::CatalogueOffer.all.map { |offer| [offer.price_info, offer.id] } }
	filter :barcode, as: :select, collection: proc { BxBlockCatalogue::Barcode.all.map { |code| [code.bar_code, code.id] } }
	filter :product_content_retail_price, as: :numeric, label: 'Retail Price'
	filter :product_content_mrp, as: :numeric, label: 'MRP'
	filter :seller, as: :select, collection: proc { AccountBlock::Account.all.where(user_type: 'seller').map { |seller| [seller.full_name, seller.id] } }
	filter :fulfilled_type, as: :select, collection: [["ByEzzy","byezzy"],["Partner","partner"]]
	filter :product_type, as: :select, collection: [["Standard","standard"],["Rapid","rapid"]]
	filter :content_status, as: :select, collection: [["Under Review","under_review"],["Accepted","accepted"],["Rejected","rejected"],["Archived","archived"]]
	filter :sku_or_product_variant_group_product_sku_cont, as: :string, label: 'SKU' do |catalogues, value|
		catalogues.joins(:product_variant_group)
		.where('catalogues.sku ILIKE ? OR product_variant_groups.product_sku ILIKE ?', "%#{value}%", "%#{value}%")
	end
	filter :besku_or_product_variant_group_product_besku_cont, as: :string, label: 'BESKU' do |catalogues, value|
		catalogues.joins(:product_variant_group)
		.where('catalogues.besku ILIKE ? OR product_variant_groups.product_besku ILIKE ?', "%#{value}%", "%#{value}%")
	end
	filter :product_title
	filter :is_variant
	filter :status
	filter :created_at, as: :date_range
	filter :updated_at, as: :date_range

	index do
		selectable_column
		id_column
		column :sku
		column :besku do |besku|
		  besku.product_variant_group&.product_besku || besku.besku
		end
		column :product_title do |product|
			truncate(product.product_title, length: 30)
		end
		column :product_image do |product|
			image_tag(product.product_image, size: '50x50') if product.product_image.attached?
		end
		column :is_variant
		column :created_at
		column :updated_at
		column :status
			actions defaults: false do |catalogue|
				item "View", admin_product_path(catalogue), class: "view_link member_link"
				item "Edit", edit_admin_product_path(catalogue), class: "edit_link member_link"
				if params[:scope] == 'archived'
					item "Unarchive", unarchive_admin_product_path(catalogue), class: "delete_link member_link", method: :put, data: { confirm: "Are you sure you want to unarchive this?" }
				else
					item "Archive", archive_admin_product_path(catalogue), class: "delete_link member_link", method: :put, data: { confirm: "Are you sure you want to archive this?" }
				end
			end
		end

	member_action :archive, method: :put do
		resource.update(content_status: 'archived')
		redirect_back(fallback_location: admin_products_path, notice: "Product archived.")
	end

	member_action :unarchive, method: :put do
		resource.update(content_status: 'under_review') 
		redirect_back(fallback_location: admin_products_path, notice: "Product unarchived.")
	end

	form do |f|
		f.inputs 'Catalogue Details' do

			f.input :category, label: 'Category', as: :select, 
			collection: BxBlockCategories::Category.all.pluck(:name,:id)

			f.input :brand, label: 'Brand', as: :select, collection: BxBlockCatalogue::Brand.pluck(:brand_name, :id)
			f.input :sku
        	f.input :besku, as: :hidden
        	# , input_html: { readonly: true, value: f.object.parent_catalogue&.besku }
			f.input :product_title
			if f.object.product_image.attached?
				f.input :product_image, as: :file, hint: image_tag(url_for(f.object.product_image), size: '100x100')
			else
				f.input :product_image, as: :file
			end
			f.input :fulfilled_type, as: :select, collection: [["ByEzzy","byezzy"],["Partner","partner"]]
			f.input :product_type, as: :select, collection: [["Standard","standard"],["Rapid","rapid"]]
			f.input :content_status, as: :select, collection: [["Under Review","under_review"],["Accepted","accepted"],["Rejected","rejected"],["Archived","archived"]]
			selected_seller_id = params[:seller_id].presence || f.object.seller_id
			f.input :seller_id, as: :select, collection: AccountBlock::Account.where(user_type: 'seller').all.map { |c| [c.full_name , c.id] }, selected: selected_seller_id
			f.input :recommended_priority, as: :select, collection: (0..9)
			f.input :status
		end

		f.actions
	end

	show do
		attributes_table do
			row :id
			if resource&.is_variant
				row :parent_product
			end
			row :sku
			row :besku
			row :bibc
			row :product_title do |product|
				div style: "width: 50%;" do
					product.product_title
				end
			end
			row :product_image do |product|
				image_tag(product.product_image, size: '100x100') if product.product_image.attached?
			end
			row :seller do |product|
				link_to product.seller.full_name, admin_seller_account_path(product.seller) if product.seller.present?
			end
			row :stocks
			row :purchased_count
			row :is_variant
			row :recommended_priority
			row :product_type
			row :fulfilled_type
			row :content_status
			row :final_price
			row :stroked_price
			row :offer_percentage
			row :status
			row :created_at
			row :updated_at
		end

		panel 'Categories' do
			table_for [resource] do
				column 'Category' do |catalogue|
					catalogue.category.name if catalogue.category
				end

				column 'Subcategory' do |catalogue|
					catalogue.sub_category.name if catalogue.sub_category
				end

				column 'MiniCategory' do |catalogue|
					catalogue.mini_category.name if catalogue.mini_category
				end

				column 'MicroCategory' do |catalogue|
					catalogue.micro_category.name if catalogue.micro_category
				end
			end
		end

		panel 'Brand' do
			table_for resource.brand do
				column :brand_name
				column :brand_year
				column :brand_website
				column :approve
			end
		end

		panel 'Contents' do
			
			table_for resource.product_content do
				if resource.product_content.present?
					column :id
					column :gtin
					column :unique_psku
					column :brand_name
					column :product_title do |product|
						truncate(product.product_title, length: 30)
					end
					column :mrp
					column :retail_price
					column 'Long Description' do |product|
						truncate(product.long_description, length: 30)
					end					
					column :whats_in_the_package do |product|
						truncate(product.whats_in_the_package, length: 30)
					end	
					column :country_of_origin
					column :warranty_days
					column :warranty_months
					column 'Actions' do |content|
						link_to 'View', admin_product_content_path(content)
					end
				else
					div link_to('Create Content', new_admin_product_content_path(catalogue_id: resource.id), class: 'button')
					br
				end
			end
			
		end

		panel 'Custom Fields Contents' do
			table_for resource.catalogue_contents.order(created_at: :asc) do
				if resource.catalogue_contents.present?
					column :custom_field_name
					column :value
					column 'Actions' do |content|
						link_to 'Edit', edit_admin_catalogue_content_path(content)
					end
				end
			end
		end

		panel 'Product Variants' do
			table_for resource.product_variant_group || resource.product_variant_groups do
				column :product_sku
				column :product_besku
				column :product_bibc
				column 'Actions' do |variant|
					link_to 'View', admin_product_variant_group_path(variant)
				end
			end
			unless resource.is_variant
				div link_to('Create Variants', new_admin_product_variant_group_path(catalogue_id: resource.id), class: 'button')
			end
			br
		end

		panel 'Seller Deal' do
			table_for resource.deal_catalogues do
				if resource.deal_catalogues.present?
					column :deal do |deal_catalogue|
						deal_catalogue.deal.deal_name
					end
					column :deal_price
					column :status
					column 'Actions' do |seller_deal|
						link_to 'View', admin_seller_deal_path(seller_deal)
					end
				else
					div link_to('Create Seller Deal', new_admin_seller_deal_path(catalogue_id: resource.id), class: 'button')
					br
				end

			end
		end

		panel 'Offer' do
			table_for resource.catalogue_offer do
				if resource.catalogue_offer
					column :price_info
					column :sale_price
					column :bar_code_info
					column :sale_schedule_from
					column :sale_schedule_to 
					column :warranty
					column :comments
					column :status
					column 'Actions' do |offer|
						link_to 'View', admin_product_offer_path(offer)
					end
				else
					div link_to('Create Offer', new_admin_product_offer_path(catalogue_id: resource.id), class: 'button')
					br
				end
			end
		end

		panel 'Barcode' do
			table_for resource.barcode do
				if resource.barcode
					column :bar_code
					column :status
					column 'Actions' do |barcode|
						link_to 'View', admin_product_barcode_path(barcode)
					end
				else
					div link_to('Create Barcode', new_admin_product_barcode_path(catalogue_id: resource.id), class: 'button')
					br
				end 
			end
		end

		active_admin_comments
	end

	
	action_item :archive, only: :show do
		if resource.content_status == 'archived'
			link_to 'Unarchive', unarchive_admin_product_path(resource), method: :put, data: { confirm: 'Are you sure you want to unarchive this?' }
		else
			link_to 'Archive', archive_admin_product_path(resource), method: :put, data: { confirm: 'Are you sure you want to archive this?' }
		end
	end

end
