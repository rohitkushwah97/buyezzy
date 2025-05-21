module BxBlockProfile
  class UniversitySerializer
    include FastJsonapi::ObjectSerializer

    attributes(:id, :name, :created_at, :updated_at)

  end
end