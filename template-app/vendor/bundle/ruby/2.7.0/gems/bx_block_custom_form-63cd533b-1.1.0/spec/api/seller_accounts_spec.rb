require 'rails_helper'

RSpec.describe '/custom_form', :jwt do
  let(:account) { create :email_account }
  let(:id)      { account.id }

  let!(:seller_account) { create :seller_account, account_id: account.id }

  describe 'test' do

    it 'testing factory' do
      expect(BxBlockCustomForm::SellerAccount.count).to eq 1
      expect(seller_account.account_id).to eq account.id
    end

  end
end
