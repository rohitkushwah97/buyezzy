module AccountBlock
  class CitySerializer
    include FastJsonapi::ObjectSerializer

    attributes(:id, :name, :created_at, :updated_at)

  end
end