module BxBlockSurveys
  class QuestionsAndAnswersSerializer < BuilderBase::BaseSerializer

    attribute :question do |object|
      question = object&.question
      {
        id: question&.id,
        name: question&.intern_question
      }
    end

    attribute :selected_option do |object|
      option = object&.option
      {
        id: option&.id,
        name: option&.name
      }
    end
  end
end