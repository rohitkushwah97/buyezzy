ActiveAdmin.register BxBlockCategories::SubCategory, as: 'SubCategories' do
  permit_params :name, :parent_id, custom_fields_attributes: [:id, :field_name, :data_type, :mandatory, :_destroy, custom_fields_options_attributes: [:id, :option_name, :_destroy]]

  show do
    attributes_table do
      row :id
      row :name
      row :category do |sub_category|
        sub_category.category&.name
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
              resource.custom_fields.each do |field|
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


  form do |f|
    f.semantic_errors *f.object.errors.keys, class: 'inline-errors'
    f.inputs do
      f.input :name
      f.input :category, as: :select, collection: BxBlockCategories::Category.all.map { |c| [c.name,c.id] }
    end

    f.has_many :custom_fields, allow_destroy: true, heading: 'Custom Fields', new_record: 'Add Custom Field' do |cf|
      cf.input :field_name
      cf.input :mandatory, as: :boolean
      cf.has_many :custom_fields_options, allow_destroy: true, heading: 'Custom Field Options', new_record: 'Add Option' do |cfo|
        cfo.input :option_name
      end
    end
    f.actions
  end

  controller do
    def create
      create! do |success, failure|
        success.html do
          redirect_to admin_category_path(resource.category)
        end
        failure.html do
          render new_admin_sub_category_path(resource)
        end
      end
    end

    def update
      update! do |success, failure|
        success.html do
          redirect_to admin_category_path(resource.category)
        end
        failure.html do
          render edit_admin_sub_category_path(resource)
        end
      end
    end

    def destroy
      destroy! do |format|
        format.html { redirect_to admin_category_path(resource.category) }
      end
    end
  end

  menu if: proc { false }
  # menu parent: 'Categories'

end
