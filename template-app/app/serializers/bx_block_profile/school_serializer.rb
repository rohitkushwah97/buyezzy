module BxBlockProfile
  class SchoolSerializer
    include FastJsonapi::ObjectSerializer

    attributes(:id, :name, :created_at, :updated_at)

  end
end