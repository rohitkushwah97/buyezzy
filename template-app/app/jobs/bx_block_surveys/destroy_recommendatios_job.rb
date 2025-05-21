module BxBlockSurveys
  class DestroyRecommendatiosJob < ApplicationJob  
    queue_as :default

    def perform(account,role_id)
      recommendations = account.recommendations.where(role_id: role_id)
      recommendations.destroy_all if recommendations.present?
    end
  end
end