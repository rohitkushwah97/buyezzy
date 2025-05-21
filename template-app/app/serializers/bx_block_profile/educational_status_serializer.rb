module BxBlockProfile
  class EducationalStatusSerializer
    include FastJsonapi::ObjectSerializer

    attributes(:id, :name, :code, :created_at, :updated_at)

  end
end