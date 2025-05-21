module BxBlockCategories
  class RoleSerializer
    include FastJsonapi::ObjectSerializer

    attributes(:id, :name, :created_at, :updated_at, :industry_id)
  end
end
  