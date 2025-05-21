module BxBlockSurveys
  class InternCharacteristic < BuilderBase::ApplicationRecord
    self.table_name = :intern_characteristics

    has_many :bx_block_surveys_questions, class_name: "BxBlockSurveys::Question"
    has_many :bx_block_surveys_submissions, class_name: "BxBlockSurveys::Submission"
    has_many :intern_characteristic_importances,class_name: "BxBlockSurveys::InternCharacteristicImportance",foreign_key:"intern_characteristic_id",dependent: :destroy
    validates :name, presence: true
    
	end
end