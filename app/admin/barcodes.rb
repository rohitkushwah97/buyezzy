ActiveAdmin.register BxBlockCatalogue::Barcode, as: 'Product Barcode' do
	permit_params :bar_code, :status, :catalogue_id

	menu if: proc { false }

	form do |f|
		f.inputs 'Barcode Details' do

			selected_catalogue_id = params[:catalogue_id].presence || f.object.catalogue_id
			f.input :catalogue_id, as: :select, collection: BxBlockCatalogue::Catalogue.all.map { |c| [c.sku , c.id] }, selected: selected_catalogue_id
			f.input :bar_code

			f.input :status
		end

		f.actions do
			f.action :submit
			f.action :cancel, wrapper_html: { class: 'cancel' }
		end
	end 

	controller do
		def update

			update! do |format|
				format.html { redirect_to admin_product_path(resource.catalogue) }
			end
			
		end
	end
end