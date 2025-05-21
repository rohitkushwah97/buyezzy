module BxBlockProfile
  class AcademicLevelSerializer
    include FastJsonapi::ObjectSerializer

    attributes(:id, :name, :created_at, :updated_at)

  end
end