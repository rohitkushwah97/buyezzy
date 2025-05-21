ActiveAdmin.register BxBlockDashboard::TrendingProduct, as: 'Trending Products' do
	menu parent: 'Home Page'
	permit_params :slider, :sale_ad_image, trending_product_selections_attributes: [:id, :catalogue_id, :_destroy]

	filter :slider, as: :select, collection: BxBlockDashboard::TrendingProduct.sliders.map { |k,v| [k.titleize, v] }
	filter :trending_product_selections_catalogue_id, as: :select, collection: proc { BxBlockCatalogue::Catalogue.all.where(status: true).order(created_at: :desc).map { |obj| [obj.sku, obj.id] } }, label: "Products"

	form do |f|
		f.semantic_errors *f.object.errors.keys, class: 'inline-errors'
		f.inputs "Trending Product Details" do
			f.input :slider, as: :select, collection: BxBlockDashboard::TrendingProduct.sliders.keys.map { |s| [s.titleize, s] }
			if f.object.sale_ad_image.attached?
				f.input :sale_ad_image, as: :file, hint: image_tag(url_for(f.object.sale_ad_image), size: '100x100')
			else
				f.input :sale_ad_image, as: :file
			end
			f.has_many :trending_product_selections, heading: 'Catalogues', allow_destroy: true do |cs|
				cs.input :catalogue_id, as: :select, collection: BxBlockCatalogue::Catalogue.all.map { |c| 
              if c.is_variant
                ["#{c.sku} >> #{c.product_variant_group&.product_sku}", c.id]
              else
                [c.sku, c.id]
              end
            }, label: 'Catalogue'
			end
		end
		f.actions
	end

	show do
		attributes_table do
			row :slider
			row :sale_ad_image do |deal|
				image_tag(deal.sale_ad_image, size: '100x100') if deal.sale_ad_image.attached?
			end
			row :created_at
			row :updated_at
		end

		panel 'Catalogues' do
			table_for resource.trending_product_selections do
				column('ID') { |selection| link_to selection.catalogue_id, admin_product_path(selection.catalogue_id) }
				column :sku do |selection| 
					(selection.catalogue.is_variant ? selection.catalogue&.product_variant_group&.product_sku : selection.catalogue.sku)
				end
				column :besku do |selection| 
					selection.catalogue.besku 
				end
				column :product_title do |selection| 
					selection.catalogue&.product_content&.product_title 
				end
				column 'Actions' do |selection|
					link_to 'View', admin_product_path(selection.catalogue_id)
				end
			end
		end
	end
	
end
