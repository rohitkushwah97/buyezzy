module BxBlockSurveys
  class Submission < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_surveys_submissions
    
    belongs_to :question, class_name: "BxBlockSurveys::Question"
    belongs_to :account, class_name: "AccountBlock::Account"
	end
end
