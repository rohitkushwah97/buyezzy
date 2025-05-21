module BxBlockRecommendation
  class CreateRecommendationsJob < ApplicationJob
    queue_as :default

    def perform(version_id,role_id)
      begin
        @role_id = role_id
        Recommendation.where(role_id: role_id).destroy_all
        intern_user_sueveys = BxBlockSurveys::UserSurvey.includes(submissions: :question).where(internship_id: nil ,quiz_status: "completed",role_id: role_id,version_id: version_id)
        @business_user_surveys = BxBlockSurveys::UserSurvey.includes(:submissions).where(career_interest_id: nil ,quiz_status: "completed",role_id: role_id,version_id: version_id)
        @threshold_percentage = Threshold.first.threshold_percentage
        intern_user_sueveys.each do |user_survey|
         calculate_compatibility_score(user_survey)
        end
        puts "recommendations created"
      rescue StandardError => e
         puts "#{e}"
      end
    end

    private

    def calculate_compatibility_score(user_survey)
      @business_user_surveys.each do |business_user_survey|
        CalculateScore.new.calculate_score(user_survey,business_user_survey,@threshold_percentage,user_survey.account,nil)
      end
    end
  end
end  