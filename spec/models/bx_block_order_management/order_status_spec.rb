# spec/models/bx_block_order_management/order_status_spec.rb

require 'rails_helper'

RSpec.describe BxBlockOrderManagement::OrderStatus, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:order_items) }
  end

  # describe 'validations' do
  #   it { is_expected.to validate_uniqueness_of(:name) }
  # end

  describe 'scopes' do
    describe '.new_statuses' do
      it 'returns order statuses excluding certain predefined statuses' do
        excluded_statuses = %i[in_cart created placed confirmed in_transit delivered cancelled refunded payment_failed returned payment_pending]
        expect(described_class.new_statuses.pluck(:status)).not_to include(*excluded_statuses)
      end
    end
  end

  describe 'constants' do
    it 'defines USER_STATUSES constant' do
      expect(described_class::USER_STATUSES).to eq(%w[in_cart created placed payment_failed payment_pending])
    end

    it 'defines CUSTOM_STATUSES constant' do
      expect(described_class::CUSTOM_STATUSES).to eq(%w[in_cart created placed confirmed in_transit delivered cancelled refunded payment_failed returned payment_pending])
    end
  end

  describe 'callbacks' do
    describe 'before_save :add_status' do
      it 'does not override status and event_name if they are already present' do
        order_status = described_class.new(name: Faker::Lorem.characters(number: 10).gsub(/\d/, '').upcase, status: 'custom_status', event_name: 'custom_event')
        order_status.save!
        expect(order_status.status).to eq('custom_status')
        expect(order_status.event_name).to eq('custom_event')
      end
    end
  end
end
