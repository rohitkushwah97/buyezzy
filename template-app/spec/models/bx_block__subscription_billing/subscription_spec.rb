require 'rails_helper'

RSpec.describe BxBlockSubscriptionBilling::Subscription, type: :model do
  describe '.ransackable_attributes' do
    it 'returns the allowed attributes for Ransack searching' do
      expect(described_class.ransackable_attributes).to match_array(
        ["id", "title", "amount", "created_at", "updated_at"]
      )
    end
  end

  describe 'database columns' do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:amount).of_type(:integer) }
  end
end
