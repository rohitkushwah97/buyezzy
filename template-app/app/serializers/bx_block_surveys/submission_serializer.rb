module BxBlockSurveys
  class SubmissionSerializer < BuilderBase::BaseSerializer

    attribute :question do |object,params|
      question = object&.question
      {
        id: question&.id,
        name: params[:type] == "BusinessUser" ? question&.business_question : question&.intern_question
      }
    end

    attribute :selected_option do |object|
      option = object&.option
      {
        id: option&.id,
        name: option&.name,
        option: object&.option_value
      }
    end

    attribute :version_id do |object|
      object&.question&.version_id
    end 
  end
end