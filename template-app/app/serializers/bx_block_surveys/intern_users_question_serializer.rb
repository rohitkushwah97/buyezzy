module BxBlockSurveys
  class InternUsersQuestionSerializer < BuilderBase::BaseSerializer
    attributes :id, :survey_id, :default_weight, :intern_question, :intern_characteristic_id 

    attribute :options do |object|
      BxBlockSurveys::OptionsSerializer.new(object.options)
    end
  end
end
