module BxBlockCatalogue
  class ExpireOffersAndDealsJob < ApplicationJob
    queue_as :default

    def perform(*args)
      # Expire catalogue offers
      CatalogueOffer.where('sale_schedule_to < ?', Time.current).find_each do |offer|
        offer.update(status: false) # Set inactive
      end

      # Expire deals
      Deal.where('end_date < ?', Time.current).find_each do |deal|
        deal.status = false
        deal.save(validate: false) # Deactivate deal
        deal.deal_catalogues.update_all(status: :expired)
      end
    end
  end
end