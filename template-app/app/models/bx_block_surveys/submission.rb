module BxBlockSurveys
  class Submission < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_surveys_submissions
    
    enum option_value: { a: 0, b: 1, c: 2, d: 3, e: 4 }
    default_scope { order(id: :asc) }

    OPTION_VALUE_MAPPING = {
      "a" => 0.2,
      "b" => 0.4,
      "c" => 0.6,
      "d" => 0.8,
      "e" => 1.0
    }

    def option_value_float
      OPTION_VALUE_MAPPING[option_value]
    end

    validates :option_value, presence: true

    belongs_to :question, class_name: "BxBlockSurveys::Question"
    belongs_to :option, class_name: "BxBlockSurveys::Option",foreign_key: 'option_id'
    belongs_to :intern_characteristic, class_name: "BxBlockSurveys::InternCharacteristic",foreign_key: 'intern_characteristic_id'
    belongs_to :user_survey, class_name: "BxBlockSurveys::UserSurvey",foreign_key: 'account_id'
  end
end
