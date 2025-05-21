module BxBlockSurveys
	class InternCharacteristicImportance < BuilderBase::ApplicationRecord
		self.table_name = :intern_characteristic_importances

		belongs_to :user_survey, class_name:"BxBlockSurveys::UserSurvey",foreign_key:"user_surveys_id"
		belongs_to :intern_characteristic, class_name: "BxBlockSurveys::InternCharacteristic",foreign_key: 'intern_characteristic_id'

		validates :value, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: "must be between 0 and 100" }
	end
end