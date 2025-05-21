module BxBlockSurveys
	class UserSurvey < BuilderBase::ApplicationRecord
		self.table_name = :user_surveys

		belongs_to :account, class_name: "AccountBlock::Account",foreign_key: 'account_id'
		belongs_to :career_interest, class_name: "BxBlockProfile::CareerInterest",optional: true
		belongs_to :internship, class_name: "BxBlockNavmenu::Internship",foreign_key: 'internship_id',optional:true
		has_many :intern_characteristic_importances,class_name: "BxBlockSurveys::InternCharacteristicImportance",foreign_key:"user_surveys_id",dependent: :destroy
		has_many :submissions, class_name: 'BxBlockSurveys::Submission',dependent: :destroy,foreign_key: 'account_id'
		after_update :create_recommendations
		before_destroy :destroy_recommendations

		private

		def create_recommendations
			if self.account.type == "InternUser"
				BxBlockRecommendation::CreateInternshipRecommendationsJob.perform_later(self.account,self.role_id)				
			end
		end

		def destroy_recommendations
			DestroyRecommendatiosJob.perform_later(self.account,self.role_id) if account.type == 'InternUser'
		end
	end
end