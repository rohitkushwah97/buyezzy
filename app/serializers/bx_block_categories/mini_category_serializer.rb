module BxBlockCategories
	class MiniCategorySerializer < BuilderBase::BaseSerializer
		attributes :id, :name, :sub_category_id

		attributes :relation do |object|
			if object.present?
				"#{object.sub_category.category.name} >> #{object.sub_category.name}"
			end
		end

		attributes :created_at, :updated_at

		attributes :micro_categories do |object|
			object.micro_categories.map do |micro_category|
				{
					id: micro_category.id,
					name: micro_category.name,
					relation: "#{object.sub_category.category.name} >> #{object.sub_category.name} >> #{object.name}",
				}
			end
		end
	end
end
