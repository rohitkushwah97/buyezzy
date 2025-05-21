ActiveAdmin.register BxBlockCategories::MicroCategory, as: 'MicroCategory' do
	permit_params :name, :mini_category_id, custom_fields_attributes: [:id, :field_name, :data_type, :mandatory, :_destroy, custom_fields_options_attributes: [:id, :option_name, :_destroy]]


	form do |f|
		f.inputs do
			f.input :mini_category, as: :select, collection: BxBlockCategories::MiniCategory.all.map { |m| [m.name,m.id] }
			f.input :name
		end

		f.has_many :custom_fields, allow_destroy: true, heading: 'Custom Fields', new_record: 'Add Custom Field' do |cf|
			cf.input :field_name
			cf.input :mandatory, as: :boolean
			cf.has_many :custom_fields_options, allow_destroy: true, heading: 'Custom Field Options', new_record: 'Add Option' do |cfo|
				cfo.input :option_name
				br
			end
		end

		f.actions
	end

	show do
		attributes_table do
			row :name
			row :mini_category do |micro_category|
				micro_category&.mini_category&.name
			end
			row :sub_category do |micro_category|
				micro_category&.sub_category&.name
			end
			row 'Category' do |mini_category|
				micro_category&.category&.name
			end
			row "Custom Fields" do
				ul do
					table do
						thead do
							tr do
								th "Field Name"
								th "Mandatory"
								th "Options"
							end
						end
						tbody do
							micro_category.custom_fields.each do |field|
								tr do
									td truncate(field.field_name, length: 30)
									td field.mandatory ? "Yes" : "No"
									td do
										ul do
											field.custom_fields_options.each do |option|
												li truncate(option.option_name, length: 30)
											end
										end
									end
								end
							end
						end
					end
				end
			end
			row :created_at
			row :updated_at
		end
	end

	controller do
		def create
			create! do |success, failure|
				success.html do
					redirect_to admin_category_path(resource.category)
				end
				failure.html do
					render new_admin_micro_category_path(resource)
				end
			end
		end

		def update
			update! do |success, failure|
				success.html do
					redirect_to admin_category_path(resource.category)
				end
				failure.html do
					render edit_admin_micro_category_path(resource)
				end
			end
		end

		def destroy
			destroy! do |format|
				format.html { redirect_to admin_category_path(resource.mini_category.sub_category.category) }
			end
		end

	end

	menu if: proc { false }
	# menu parent: 'Categories'

end