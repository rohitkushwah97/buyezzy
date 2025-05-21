module BxBlockJoblisting
  class AnswerSerializer < BuilderBase::BaseSerializer
    attributes(:profile_id, :question_id, :company_page_id, :job_id, :description)
  end
end
