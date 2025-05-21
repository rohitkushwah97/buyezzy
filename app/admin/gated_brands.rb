ActiveAdmin.register BxBlockCatalogue::GatedBrand, as: 'Gated Brands Req' do
	permit_params :brand_id, :approved

	menu parent: 'Brands'

	filter :brand, collection: -> { BxBlockCatalogue::Brand.all.map { |brand| [brand.brand_name, brand.id] } }, as: :select
	filter :approved, as: :select, collection: [['Yes', true], ['No', false]]
	filter :brand_catalogues_sku, as: :string, label: 'Catalogue SKU', filters: [:contains]


	index do
		selectable_column
		id_column
		column :brand
		column :approved
		actions
	end

	show do
		attributes_table do
			row :brand
			row :reseller_permit_document do |brand|
				if brand.reseller_permit_document.attached?
					link_to(brand.reseller_permit_document.filename, url_for(brand.reseller_permit_document), target: '_blank')
				end
			end
			row :approved
			panel 'Catalogues' do
				table_for resource.brand.catalogues do
					column :id
					column :sku
					column :besku
					column 'Details' do |catalogue|
						link_to 'View Details', admin_product_path(catalogue)
					end
				end
			end
		end
	end

	form do |f|
		f.inputs 'Gated Brand Details' do
			f.input :brand, collection: BxBlockCatalogue::Brand.all.where(gated: true).map { |brand| [brand.brand_name, brand.id] }, prompt: 'Select Brand'
			f.input :approved
		end
		f.actions
	end

	controller do
		def scoped_collection
			end_of_association_chain.includes(brand: [:catalogues])
		end
	end

	menu if: proc { false }

end