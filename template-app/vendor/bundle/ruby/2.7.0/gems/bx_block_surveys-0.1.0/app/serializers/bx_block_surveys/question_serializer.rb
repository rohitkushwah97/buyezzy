module BxBlockSurveys
  class QuestionSerializer < BuilderBase::BaseSerializer
    attributes :id, :survey_id, :question_type, :question_title  

    attribute :options do |object|
      question_data = {}
      if object.question_type == 'checkbox' || object.question_type == 'radio'
        question_data[:options] = object.options.map { |option| { id: option.id, name: option.name } }
      end
  
      question_data[:rating] = object.rating if object.rating.present?
  
      question_data
    end
  end
end
