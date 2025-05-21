require 'rails_helper'

RSpec.describe BxBlockRecommendation::CreateInternshipRecommendationsJob, type: :job do
  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let(:business_user) { FactoryBot.create(:business_user, activated: true) }
  let!(:career_interest) { FactoryBot.create(:career_interest,intern_user_id:intern_user.id ) }
  let!(:internship) { FactoryBot.create(:bx_block_navmenu_internship,role_id: career_interest.role.id,industry_id: career_interest.industry_id,business_user_id: business_user.id,status:1) }
  let(:version) { FactoryBot.create(:version, survey_id: BxBlockSurveys::Survey.last.id) }
  let!(:question) { FactoryBot.create(:question,version_id:version.id,survey_id:version.survey_id) }

  describe "#perform_now" do
    it "create internship recommendation" do
      BxBlockSurveys::UserSurvey.update(quiz_status: "completed")
      career_interest.user_survey.submissions.create(question_id: question.id, option_id:question.options.first.id, version_id: version.id, option_value:"a", intern_characteristic_id: question.intern_characteristic_id,default_weight: question.default_weight)

      internship.user_survey.submissions.create(question_id: question.id, option_id:question.options.first.id, version_id: version.id, option_value:"a", intern_characteristic_id: question.intern_characteristic_id,default_weight: question.default_weight)

      internship.user_survey.intern_characteristic_importances.create(intern_characteristic_id:question.intern_characteristic_id, value:23)
      Threshold.create(threshold_percentage:22)

      ActiveJob::Base.queue_adapter = :test
      res = described_class.perform_now(intern_user,career_interest.role_id)
      expect(res).to eq(nil)
    end

     it "got error internship recommendation" do
      ActiveJob::Base.queue_adapter = :test
      res = described_class.perform_now(intern_user,career_interest.role_id)
      expect(res).to eq(nil)
    end
  end
end
