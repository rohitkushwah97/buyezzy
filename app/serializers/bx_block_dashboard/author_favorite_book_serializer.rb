module BxBlockDashboard
  class AuthorFavoriteBookSerializer < BuilderBase::BaseSerializer
    attributes :id, :title,:status, :created_at, :updated_at

    attributes :catalogues do |object|
      if object.favorite_book_catalogues.present?
        object.favorite_book_catalogues.map do |tps|
        	BxBlockCatalogue::CatalogueSerializer.new(tps.catalogue).serializable_hash
        end
      end
    end
  end
end
