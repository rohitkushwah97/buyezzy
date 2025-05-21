module BxBlockDashboard
  class MostPopularCategorySerializer < BuilderBase::BaseSerializer
    attributes :id, :sequence_no, :category_id, :created_at, :updated_at

    attributes :category do |object|
      if object.category
        object.category.serializable_hash
      end
    end
  end
end
