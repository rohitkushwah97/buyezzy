module BxBlockSurveys
  class SurveySerializer < BuilderBase::BaseSerializer
    attributes :id, :name, :description, :is_activated
  end
end
