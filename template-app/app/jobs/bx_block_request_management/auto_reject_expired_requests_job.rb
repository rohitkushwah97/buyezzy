module BxBlockRequestManagement
  class AutoRejectExpiredRequestsJob < ApplicationJob
    queue_as :default

    def perform
      expired_requests = RequestInterview.pending.where(
        "DATE(created_at) <= CURRENT_DATE - number_of_days"
      )

      expired_requests.find_each do |request|
        request.update(status: :rejected)

        BxBlockNavmenu::AccountInternship.where(
            internship_id: request.internship_id,
            account_id: request.intern_user_id
          ).update_all(status: "rejected")
      end
    end
  end
end
