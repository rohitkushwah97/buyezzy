module BxBlockRecommendation
  class CreateApplicantRecommendationsJob < ApplicationJob
    queue_as :default

    def perform(internship)
      begin
        @internship = internship
        @internship.recommendations.destroy_all
        @internship_survey = BxBlockSurveys::UserSurvey.includes(:submissions).find_by(internship_id: internship.id,quiz_status: 'completed')
        user_ids = AccountBlock::InternUser.joins(:career_interests).where(career_interests:{role_id: internship.role_id}).ids
        user_surveys = BxBlockSurveys::UserSurvey.includes(submissions: :question).where(account_id: user_ids,quiz_status: 'completed',version_id: @internship_survey.version_id)
        @threshold_percentage = Threshold.first.threshold_percentage
        calculate_compatibility_score(user_surveys)
        puts "recommendations created"
      rescue StandardError => e
        puts "#{e}"
      end
    end

    private

    def calculate_compatibility_score(user_surveys)
      user_surveys.each do |user_survey|
        CalculateScore.new.calculate_score(user_survey,@internship_survey,@threshold_percentage,user_survey.account,'publish')
      end
    end
  end
end
