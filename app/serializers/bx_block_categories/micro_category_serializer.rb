module BxBlockCategories
	class MicroCategorySerializer < BuilderBase::BaseSerializer
		attributes :id, :name, :mini_category_id

		attribute :sub_category_id do |object|
			object.mini_category.sub_category.id
		end

		attribute :category_id do |object|
			object.mini_category.sub_category.category.id
		end

		attributes :relation do |object|
			if object.present?
				"#{object.mini_category.sub_category.category.name} >> #{object.mini_category.sub_category.name} >> #{object.mini_category.name}"
			end
		end

		attributes :created_at, :updated_at

	end
end
