module BxBlockCategories
	class SubCategorySerializer < BuilderBase::BaseSerializer
		attributes :id, :name, :parent_id, :created_at, :updated_at

		attributes :relation do |object|
			object.category.name
		end

		attributes :mini_categories do |object, params|
			object.mini_categories.map do |mini_category|
				{
					id: mini_category.id,
					name: mini_category.name,
					micro_categories: mini_category.micro_categories.map do |microcategory|
						{
							id: microcategory.id,
							name: microcategory.name
						}
					end
				}
			end
		end

	end
end
