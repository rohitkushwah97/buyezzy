require 'rails_helper'

RSpec.describe BxBlockSurveys::DestroyRecommendatiosJob, type: :job do
  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let(:role) { FactoryBot.create(:role) }

  describe "#perform_now" do
    it "Update Default Weight" do
      ActiveJob::Base.queue_adapter = :test
      res = described_class.perform_now(intern_user,role)
      expect(res).to eq(nil)
    end
  end
end
