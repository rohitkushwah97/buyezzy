ActiveAdmin.register BxBlockCatalogue::ProductContent, as: 'Product Contents' do
	permit_params do
		permitted = [
			:catalogue_id, :gtin, :unique_psku, :brand_name, :product_title, :mrp, :retail_price, :long_description,
			:whats_in_the_package, :country_of_origin, :product_color,:warranty_days, :warranty_months,
			:size_and_capacity_attributes, :shipping_detail_attributes,
			image_urls_attributes: [:id, :url, :_destroy],
			feature_bullets_attributes: [:id, :field_name, :value, :_destroy],
			special_features_attributes: [:id, :field_name, :value, :_destroy]
		]

		if params[:product_content]
			permitted << { size_and_capacity_attributes: [:id, :size, :size_unit, :capacity, :capacity_unit, :hs_code, :prod_model_name, :prod_model_number, :number_of_pieces, :_destroy] } if params[:product_content][:size_and_capacity_attributes]&.values&.any?(&:present?)
			permitted << { shipping_detail_attributes: [:id, :shipping_length, :shipping_length_unit, :shipping_height, :shipping_height_unit, :shipping_width, :shipping_width_unit, :shipping_weight, :shipping_weight_unit, :_destroy] } if params[:product_content][:shipping_detail_attributes]&.values&.any?(&:present?)
		end

		permitted
	end

	menu if: proc { false }

	index do
		selectable_column
		id_column
		column :catalogue
		column :gtin
		column :unique_psku
		column :brand_name
		column :product_title do |product|
			truncate(product.product_title, length: 30)
		end
		column :mrp
		column :retail_price
	end

	show do
		attributes_table do
			row :catalogue
			row :gtin
			row :unique_psku
			row :brand_name
			row :product_title do |product|
				div style: "width: 50%;" do
					product.product_title
				end
			end
			row :mrp
			row :retail_price
			row :long_description do |product|
				div style: "width: 50%; " do
					product.long_description
				end
			end
			row :whats_in_the_package do |product|
				div style: " width: 50%;" do
					product.whats_in_the_package
				end
			end
			row :country_of_origin
			row :product_color
			row :warranty_days
			row :warranty_months
		end

		panel 'Size and Capacity' do
			attributes_table_for resource.size_and_capacity do
				row :size
				row :size_unit
				row :capacity
				row :capacity_unit
				row :hs_code
				row :prod_model_name
				row :prod_model_number
				row :number_of_pieces
			end
		end

		panel 'Shipping Detail' do
			attributes_table_for resource.shipping_detail do
				row :shipping_length
				row :shipping_length_unit
				row :shipping_height
				row :shipping_height_unit
				row :shipping_width
				row :shipping_width_unit
				row :shipping_weight
				row :shipping_weight_unit
			end
		end

		panel 'Image URLs' do
			table_for resource.image_urls do
				column :url
			end
		end

		panel 'Feature Bullets' do
			table_for resource.feature_bullets do
				column :field_name
				column :value
			end
		end

	end

	form do |f|
		f.semantic_errors
		f.inputs 'Product Content Details' do
			selected_catalogue_id = params[:catalogue_id].presence || f.object.catalogue_id
			f.input :catalogue_id, as: :select, collection: BxBlockCatalogue::Catalogue.all.map { |c| [c.sku , c.id] }, selected: selected_catalogue_id
			f.input :gtin
			f.input :unique_psku
			f.input :brand_name
			f.input :product_title
			f.input :mrp
			f.input :retail_price
			f.input :long_description
			f.input :whats_in_the_package
			f.input :country_of_origin
			f.input :product_color, as: :string
			f.input :warranty_days
			f.input :warranty_months
		end

		f.inputs 'Size and Capacity' do
			f.semantic_fields_for :size_and_capacity_attributes, (f.object.size_and_capacity || f.object.build_size_and_capacity) do |size_and_capacity|
				size_and_capacity.input :size
				size_and_capacity.input :size_unit
				size_and_capacity.input :capacity
				size_and_capacity.input :capacity_unit
				size_and_capacity.input :hs_code
				size_and_capacity.input :prod_model_name
				size_and_capacity.input :prod_model_number
				size_and_capacity.input :number_of_pieces
			end
		end

		f.inputs 'Shipping Detail' do
			f.semantic_fields_for :shipping_detail_attributes, (f.object.shipping_detail || f.object.build_shipping_detail) do |shipping_detail|
				shipping_detail.input :shipping_length
				shipping_detail.input :shipping_length_unit
				shipping_detail.input :shipping_height
				shipping_detail.input :shipping_height_unit
				shipping_detail.input :shipping_width
				shipping_detail.input :shipping_width_unit
				shipping_detail.input :shipping_weight
				shipping_detail.input :shipping_weight_unit
			end
		end

		f.inputs 'Image URLs*' do
			f.has_many :image_urls, allow_destroy: true do |image_url|
				image_url.input :url
			end
		end

		f.inputs 'Feature Bullets*' do
			f.has_many :feature_bullets, allow_destroy: true do |feature_bullet|
				feature_bullet.input :field_name, hint: "(e.g., Feature Bullet 1, Feature Bullet 2, ...)"
				feature_bullet.input :value
			end
		end

		f.actions
	end

	controller do

		def create
			super do |success, failure|
				failure.html do
					flash[:main_model_errors] = resource.errors.full_messages.join(', ')
					if resource.image_urls.blank?
						flash[:image_urls_errors] = "Image URLs: At least one Image Url must be present"
					end
					if resource.feature_bullets.blank?
						flash[:feature_bullets_errors] = "Feature Bullets: At least one Feature Bullet must be present"
					end

					render :new
				end
			end
		end

		def update
			super do |success, failure|
				failure.html do
					flash[:main_model_errors] = resource.errors.full_messages.join(', ')
					if resource.image_urls.blank?
						flash[:image_urls_errors] = "Image URLs: At least one Image Url must be present"
					end
					if resource.feature_bullets.blank?
						flash[:feature_bullets_errors] = "Feature Bullets: At least one Feature Bullet must be present"
					end
					
					render :edit
				end
			end
		end

		def destroy
			def destroy
				destroy! do |format|
					format.html { redirect_to admin_product_path(resource.catalogue), notice: "Product Content was successfully destroyed." }
				end
			end
		end

	end
end
