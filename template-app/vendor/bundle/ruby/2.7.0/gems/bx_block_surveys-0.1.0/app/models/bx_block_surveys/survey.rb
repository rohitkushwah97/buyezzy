module BxBlockSurveys
  class Survey < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_surveys_surveys
    
    has_many :questions, class_name: 'BxBlockSurveys::Question', dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true
    validates :name, :description, presence: true
	end
end
