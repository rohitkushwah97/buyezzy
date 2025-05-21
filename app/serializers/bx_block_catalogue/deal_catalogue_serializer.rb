module BxBlockCatalogue
  class DealCatalogueSerializer < BuilderBase::BaseSerializer
    attributes :id, :deal_id, :catalogue_id,:seller_id, :seller_sku, :product_title, :seller_price, :current_offer_price, :deal_price, :status, :created_at,:updated_at 

    attribute :seller do |object|
      AccountBlock::AccountSerializer.new(object.seller)
    end

    attributes :deal do |object|
      if object.deal
        DealSerializer.new(object.deal)
      end
    end

    attribute :catalogue_full_details do |object|
      if object.catalogue
        CatalogueSerializer.new(object.catalogue)
      end
    end

  end
end
