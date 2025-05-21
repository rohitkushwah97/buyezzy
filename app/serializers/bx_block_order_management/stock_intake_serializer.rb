module BxBlockOrderManagement
  class StockIntakeSerializer < BuilderBase::BaseSerializer
    attributes :id, :stock_value, :stock_qty, :ship_date, :receiving_date, :status, :created_at, :updated_at

    attribute :seller do |object|
      AccountBlock::AccountSerializer.new(object.seller)
    end

    attribute :catalogue do |object|
      BxBlockCatalogue::CatalogueSerializer.new(object.catalogue)
    end

  end
end