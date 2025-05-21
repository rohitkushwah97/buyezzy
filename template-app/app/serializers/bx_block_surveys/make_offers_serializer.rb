module BxBlockSurveys
  class MakeOffersSerializer < BuilderBase::BaseSerializer
    attributes :intern_user_id, :business_user_id, :internship_id, :offer_status, :number_of_days
  end
end
