module AccountBlock
  class CountrySerializer
    include FastJsonapi::ObjectSerializer

    attributes(:id, :name, :created_at, :updated_at)

  end
end