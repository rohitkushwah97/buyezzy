ActiveAdmin.register BxBlockCatalogue::CatalogueContent, as: 'Catalogue Content' do
	permit_params :custom_field_name, :value, :custom_field_id, :catalogue_id, :status

	menu if: proc { false }

	form do |f|
		f.inputs 'Catalogue Content Details' do
			f.hidden_field :custom_field_name, value: f.object.custom_field_name
			f.hidden_field :custom_field_id, value: f.object.custom_field_id
			f.hidden_field :catalogue_id, value: f.object.catalogue_id
			f.input :value
		end

		f.actions
	end

	controller do
		def update

			update! do |format|
				if resource.errors.any?
					flash[:error] = resource.errors.full_messages.join(', ')
				end
				format.html { redirect_to admin_product_path(resource.catalogue) }
			end
			
		end
	end
end