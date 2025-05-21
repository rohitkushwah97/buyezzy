module BxBlockSurveys
  class AutoRejectOfferJob < ApplicationJob
    queue_as :default

    # def perform
    #   expiration_time = 7.days.ago

    #   BxBlockSurveys::MakeOffer.pending.where('created_at <= ?', expiration_time).find_each do |offer|
    #     offer.rejected!
    #   end
    # end

    def perform
      BxBlockSurveys::MakeOffer.pending.find_each do |offer|
        expiry_date = offer.created_at.to_date + offer.number_of_days

        if Date.today >= expiry_date
          offer.update(offer_status: "rejected")

          BxBlockNavmenu::AccountInternship.where(
            internship_id: offer.internship_id,
            account_id: offer.intern_user_id
          ).update_all(status: "rejected")
        end
      end
    end
  end
end
