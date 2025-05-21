module BxBlockSurveys
  class SurveyQuestionSerializer < BuilderBase::BaseSerializer
    attributes :id, :name, :description

    attribute :questions do |object|
      object.questions.map do |question|
        question_data = {
          id: question.id,
          question_type: question.question_type,
          question_title: question.question_title,
          survey_id: question.survey_id
        }
    
        if question.question_type == 'checkbox' || question.question_type == 'radio'
          question_data[:options] = question.options.map { |option| { id: option.id, name: option.name } }
        end
    
        question_data[:rating] = question.rating if question.rating.present?
    
        question_data
      end
    end
  end
end
