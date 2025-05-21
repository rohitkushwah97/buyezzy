ActiveAdmin.register BxBlockCatalogue::ProductVariantGroup, as: 'Product Variant Groups' do
	permit_params :product_sku, :product_description, :price, :product_title, :catalogue_id, product_images: [], group_attributes_attributes: [:id, :attribute_name, :option, :_destroy]

	menu if: proc { false }

	index do
		selectable_column
		id_column
		column :product_sku
		column :product_besku
		column :product_bibc
		actions
	end

	form do |f|
		f.semantic_errors

		f.inputs 'Product Variant Group Details' do
			selected_catalogue_id = params[:catalogue_id].presence || f.object.catalogue_id

			f.input :catalogue_id, as: :select, collection: BxBlockCatalogue::Catalogue.all.map { |c| [c.sku, c.id] }, selected: selected_catalogue_id
			f.input :product_sku
		end

		f.inputs 'Group Attributes' do
			f.has_many :group_attributes, allow_destroy: true, new_record: 'Add Attribute' do |attribute|
				attribute.input :attribute_name
				attribute.input :option
			end
		end

		f.actions
	end

	show do
		attributes_table do
			row :id
			row :product_sku
			row :product_besku
			row :product_bibc
			row :catalogue
		end

		panel 'Group Attributes' do
			table_for resource.group_attributes.order(created_at: :desc) do
				column :attribute_name
				column :option
			end
		end
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