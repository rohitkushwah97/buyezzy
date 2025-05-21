module BxBlockSurveys
  class SubmissionSerializer < BuilderBase::BaseSerializer

    attribute :question_answer do |object|
      option_value = []
      if object.answer_type == 'checkbox' || object.answer_type == 'radio'
        option_value = BxBlockSurveys::Option.where(id: object.option_ids).pluck(:id, :name).map { |id, name| { id: id, name: name } }
      end

      {
        id: object.question&.id,
        account_id: object&.account_id,
        question_type: object&.question&.question_type,
        question: object&.question&.question_title,
        answer: object&.answer,
        rating: object&.rating,
        option_value: option_value
      }
    end
  end
end