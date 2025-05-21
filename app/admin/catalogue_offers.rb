ActiveAdmin.register BxBlockCatalogue::CatalogueOffer, as: 'Product Offers' do
	permit_params :price_info, :sale_price, :bar_code_info, :sale_schedule_from, :sale_schedule_to, :warranty, :comments, :status, :catalogue_id, :barcode_id

	menu if: proc { false }

	form do |f|
		f.semantic_errors 

		f.inputs 'Product Offer Details' do
			f.input :price_info
			f.input :sale_price
			f.input :bar_code_info
			f.input :sale_schedule_from, as: :date_time_picker
			f.input :sale_schedule_to, as: :date_time_picker
			f.input :warranty, as: :select, collection: ["1 Month", "2 Month", "3 Month", "6 Month", "1 Year", "2 Year"]
			f.input :comments

			selected_catalogue_id = params[:catalogue_id].presence || f.object.catalogue_id
			f.input :catalogue, as: :select, collection: BxBlockCatalogue::Catalogue.all.map { |c| 
              if c.is_variant
                ["#{c.sku} >> #{c.product_variant_group&.product_sku}", c.id]
              else
                [c.sku, c.id]
              end
            }, selected: selected_catalogue_id

			f.input :barcode_id, as: :select, collection: BxBlockCatalogue::Barcode.all.map { |b| [b.bar_code, b.id] },  hint: "Create Barcode if not available"
			f.input :status
		end

		f.actions do
			f.action :submit
			f.action :cancel, wrapper_html: { class: 'cancel' }
			f.button 'Create Barcode', class: "button", type: :button, onclick: "window.open('/admin/product_barcodes/new', '_blank');"
		end
	end

	controller do
		def update

			update! do |success, failure|
				success.html do
					redirect_to admin_product_path(resource.catalogue) 
				end

				failure.html do
					render edit_admin_product_offer_path(resource)
				end
			end

		end
	end
end