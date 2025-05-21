module BxBlockDashboard
  class TopBrandSerializer < BuilderBase::BaseSerializer
    attributes :id, :sequence_no, :brand_id, :created_at, :updated_at

    attributes :brand do |object|
      if object.brand
        object.brand.serializable_hash
      end
    end
  end
end
