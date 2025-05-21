module BxBlockSalesreporting
  class ProductViewSerializer < BuilderBase::BaseSerializer
    attributes *[
      :id,
      :catalogue_id,
      :user_id,
      :viewed_at,
      :created_at,
      :updated_at
    ]

    attribute :buyer do |object|
      AccountBlock::AccountSerializer.new(object.user).serializable_hash
    end

    attribute :catalogue do |object|
      BxBlockCatalogue::CatalogueSerializer.new(object.catalogue).serializable_hash
    end

  end
end
