ActiveAdmin.register BxBlockCategories::Category, as: 'Category' do

  permit_params :name,:category_image, :header_image, custom_fields_attributes: [:id, :field_name, :data_type, :mandatory, :_destroy, custom_fields_options_attributes: [:id, :option_name, :_destroy]]


  filter :name
  filter :sub_categories, as: :select, collection: proc { BxBlockCategories::SubCategory.pluck(:name, :id) }, label: 'Subcategory'

  filter :mini_categories, as: :select, collection: proc { BxBlockCategories::MiniCategory.pluck(:name, :id) }, label: 'Mini Category'

  filter :micro_categories, as: :select, collection: proc { BxBlockCategories::MicroCategory.pluck(:name, :id) }, label: 'Micro Category'
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range



  index do
    selectable_column
    id_column
    column :name
    column :category_image do |category|
      image_tag(category.category_image, size: '50x50') if category.category_image.attached?
    end
    column :header_image do |category|
      image_tag(category.header_image, size: '50x50') if category.header_image.attached?
    end
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys, class: 'inline-errors'
    f.inputs do
      f.input :name
      if f.object.category_image.attached?
        f.input :category_image, as: :file, hint: image_tag(url_for(f.object.category_image), size: '100x100')
      else
        f.input :category_image, as: :file
      end

      if f.object.header_image.attached?
        f.input :header_image, as: :file, hint: image_tag(url_for(f.object.header_image), size: '100x100')
      else
        f.input :header_image, as: :file
      end
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

  show do

    panel 'Category' do
      div style: 'display: flex; justify-content: space-between; ' do

        div style: ' width: 65%;' do
          attributes_table do
            row :name
            row :category_image do |category|
              image_tag(category.category_image, size: '100x100') if category.category_image.attached?
            end
            row :header_image do |category|
              image_tag(category.header_image, size: '100x100') if category.header_image.attached?
            end
            row :created_at
            row :updated_at
          end
        end

        div style: 'width: 30%; text-align: left;' do
          div do
            h3 "Custom Fields"
          end
          table_for category.custom_fields do
            column :field_name
            column :mandatory
            column :options do |field|
              field.custom_fields_options.map(&:option_name).join(', ')
            end
          end
        end

      end
    end

    panel "Subcategories" do
      div style: 'display: flex;justify-content: space-between;' do
        div style: 'width: 65%; ' do
          table_for category.sub_categories do
            column "Subcategory Name" do |sub_category|
              link_to sub_category.name, admin_sub_category_path(sub_category)
            end
            column :created_at
            column :updated_at
            column :custom_fields do |sub_category|
              table_for sub_category.custom_fields do
                column :field_name
                column :mandatory
                column :options do |field|
                  field.custom_fields_options.map(&:option_name).join(', ')
                end
              end
            end
          end
        end

        div style: ' width: 30%; text-align: right;' do
          active_admin_form_for BxBlockCategories::SubCategory.new, url: admin_sub_categories_path do |f|
            f.inputs "Create Subcategory" do
              f.input :parent_id, as: :hidden, input_html: { value: category.id }
              f.input :name
              f.actions do
                f.action :submit, label: "Add Sub Category"
              end
            end
          end
        end
      end
    end

    panel "Minicategories" do
      div style: 'display: flex; justify-content: space-between;' do
        div style: ' width: 65%; ' do
          table_for category.sub_categories.flat_map(&:mini_categories) do
            column "Mini Category Name" do |mini_category|
              link_to mini_category.name, admin_mini_category_path(mini_category)
            end
            column :created_at
            column :updated_at
            column :custom_fields do |mini_category|
              table_for mini_category.custom_fields do
                column :field_name
                column :mandatory
                column :options do |field|
                  field.custom_fields_options.map(&:option_name).join(', ')
                end
              end
            end
          end
        end

        div style: 'width: 30%;text-align: right;' do
          active_admin_form_for BxBlockCategories::MiniCategory.new, url: admin_mini_categories_path do |f|
            f.inputs "Create Mini category" do
              f.input :parent_id, as: :hidden, input_html: { value: category.id }
              f.input :name
              f.input :sub_category, as: :select, collection: category.sub_categories.map { |s| [truncate(s.name, length: 40), s.id] }
              f.actions do
                f.action :submit, label: "Add Mini Category"
              end
            end
          end
        end
      end

      panel "Microcategories" do
        div style: ' display: flex; justify-content: space-between;' do
          div style: 'width: 65%; ' do
            table_for category.sub_categories.flat_map(&:mini_categories).flat_map(&:micro_categories) do
              column "Micro Category Name" do |micro_category|
                link_to micro_category.name, admin_micro_category_path(micro_category)
              end
              column :created_at
              column :updated_at
              column :custom_fields do |micro_category|
                table_for micro_category.custom_fields do
                  column :field_name
                  column :mandatory
                  column :options do |field|
                    field.custom_fields_options.map(&:option_name).join(', ')
                  end
                end
              end
            end
          end

          div style: 'width: 30%; text-align: right; ' do
            active_admin_form_for BxBlockCategories::MicroCategory.new, url: admin_micro_categories_path do |f|
              f.inputs "Create Micro category" do
                f.input :parent_id, as: :hidden, input_html: { value: category.id }
                f.input :name
                f.input :mini_category, as: :select, collection: category.sub_categories.flat_map(&:mini_categories).map { |m| [truncate(m.name, length: 40), m.id] }
                f.actions do
                  f.action :submit, label: "Add Micro Category"
                end
              end
            end
          end
        end

      end
    end
  end

end
