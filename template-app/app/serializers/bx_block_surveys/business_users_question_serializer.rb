module BxBlockSurveys
  class BusinessUsersQuestionSerializer < BuilderBase::BaseSerializer
    attributes :id, :survey_id, :default_weight, :business_question, :intern_characteristic_id 

    attribute :options do |object|
      BxBlockSurveys::OptionsSerializer.new(object.options)
    end
  end
end
