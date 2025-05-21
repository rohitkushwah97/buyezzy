module BxBlockRecommendation
  class CreateInternshipRecommendationsJob < ApplicationJob  
    queue_as :default

    def perform(user,role_id)
      begin
        @user = user
        @user.recommendations.where(role_id: role_id).destroy_all
        internship_ids = BxBlockNavmenu::Internship.where(role_id: role_id ,status:1).ids
        user_survey = BxBlockSurveys::UserSurvey.includes(submissions: :question).find_by(account_id: user.id, role_id: role_id, quiz_status: 'completed')
        @threshold_percentage = Threshold.first.threshold_percentage
        business_user_surveys = BxBlockSurveys::UserSurvey.includes(:submissions).where(internship_id: internship_ids,quiz_status:'completed',version_id: user_survey.version_id)
        calculate_compatibility_score(user_survey,business_user_surveys)
        puts "recommendations created"
      rescue StandardError => e
        puts "#{e}"
      end
    end

    private

    def calculate_compatibility_score(user_survey,business_user_surveys)
      business_user_surveys.each do |business_user_survey|
        CalculateScore.new.calculate_score(user_survey,business_user_survey,@threshold_percentage,@user,nil)
      end
    end
  end
end
