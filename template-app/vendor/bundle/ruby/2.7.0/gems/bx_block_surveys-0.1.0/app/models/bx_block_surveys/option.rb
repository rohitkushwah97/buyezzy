module BxBlockSurveys
  class Option < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_surveys_options
    
    belongs_to :question, class_name: "BxBlockSurveys::Question"
	end
end
