module BxBlockSurveys
  class InternUserGenericAnswerSerializer < BuilderBase::BaseSerializer
    attribute :question do |object|
      question = object.intern_user_generic_question
      {
        id: question.id,
        question: question.question
      }
    end
    attributes :answer
  end
end