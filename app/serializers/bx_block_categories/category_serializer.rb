module BxBlockCategories
  class CategorySerializer < BuilderBase::BaseSerializer
    attributes :id, :name, :rank, :created_at, :updated_at

    attributes :category_image do |object|
      if object.category_image.attached?
        ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.category_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.category_image, only_path: true)
      end
    end

    attributes :header_image do |object|
      if object.header_image.attached?
        ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.header_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.header_image, only_path: true)
      end
    end

    attributes :sub_categories do |object, params|
      object.sub_categories.map do |sub_category|
        {
          id: sub_category.id,
          name: sub_category.name,
          mini_categories: sub_category.mini_categories.map do |minicategory|
            {
              id: minicategory.id,
              name: minicategory.name,
              micro_categories: minicategory.micro_categories.map do |microcategory|
                {
                  id: microcategory.id,
                  name: microcategory.name
                }
              end
            }
          end
        }
      end
    end

  end
end
