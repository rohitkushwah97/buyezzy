module BxBlockWishlist
  class ErrorSerializer < BuilderBase::BaseSerializer
    attribute :errors do |item|
      item.errors.as_json
    end
  end
end
