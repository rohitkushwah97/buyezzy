module BxBlockSurvey
  module GenericQuestionHelper
    def find_generic(question)
      if question.try(:intern_user_generic_question).try(:question).present?
        question.intern_user_generic_question.question
      else
        question.business_user_generic_question.question
      end
    end
  end
end