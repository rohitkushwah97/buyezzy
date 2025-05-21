require 'rails_helper'

RSpec.describe BxBlockCatalogue::ExpireOffersAndDealsJob, type: :job do
  describe '#perform' do
    let!(:account) { FactoryBot.create(:account, user_type: 'seller') }
    let!(:catalogue) { FactoryBot.create(:catalogue, seller: account) } 
    let!(:product_content) { FactoryBot.create(:product_content, catalogue: catalogue) }
    let!(:active_offer) { FactoryBot.create(:catalogue_offer, sale_schedule_to: Time.current + 1.day, status: true) }
    let!(:expired_offer) { FactoryBot.create(:catalogue_offer, sale_schedule_to: Time.current - 1.day, status: true) }

    let!(:active_deal) { FactoryBot.create(:deal, end_date: Time.current + 1.day, status: true) }
    let!(:expired_deal) do
      deal = FactoryBot.build(:deal, start_date: Time.current - 10.days, end_date: Time.current - 1.day, status: true)
      deal.save(validate: false)
      deal
    end

    let!(:deal_catalogue) { FactoryBot.create(:deal_catalogue, deal: expired_deal, status: 'approved', seller: account) }

    it 'expires catalogue offers whose sale_schedule_to has passed' do
      described_class.perform_now
      expect(active_offer.reload.status).to eq(true)
      expect(expired_offer.reload.status).to eq(false)
    end

    it 'expires deals whose end_date has passed' do
      described_class.perform_now
      expect(active_deal.reload.status).to eq(true)
      expect(expired_deal.reload.status).to eq(false)
    end

    it 'updates the status of associated deal catalogues to expired' do
      expect { described_class.perform_now }
    .to change { deal_catalogue.reload.status }.from('approved').to('expired')
    end
  end
end