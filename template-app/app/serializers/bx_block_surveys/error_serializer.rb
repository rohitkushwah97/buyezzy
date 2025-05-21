module BxBlockSurveys
  class ErrorSerializer < BuilderBase::BaseSerializer
    attribute :errors do |make_offer|
      make_offer.errors.as_json
    end
  end
end
