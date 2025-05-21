module BxBlockSurveys
  class Option < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_surveys_options
    has_many :submissions , class_name: "BxBlockSurveys::Submission",foreign_key: 'option_id', dependent: :destroy
    belongs_to :question, class_name: "BxBlockSurveys::Question"
    validates :name, presence: true
    default_scope { order(id: :asc) }
	end
end