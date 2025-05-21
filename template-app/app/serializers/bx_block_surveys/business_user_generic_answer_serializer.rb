module BxBlockSurveys
  class BusinessUserGenericAnswerSerializer < BuilderBase::BaseSerializer
    attributes :id,:answer

    attribute :question do |object|
      BusinessUserGenericQuestionSerializer.new(object.business_user_generic_question)
    end
  end
end