require 'rails_helper'

RSpec.describe AccountBlock::BusinessUser, type: :model do
  subject(:business_user) do
    described_class.new(
      email: "john.doe@business.com",
      password: "Password1!"
    )
  end

  describe "Callbacks" do
    it "after_create" do
      response = business_user.run_callbacks(:create)
      expect(response).to eq(true)
    end
  end

  describe 'validations' do
    describe 'business email validation' do
      context 'when email is from a valid business domain' do
        it 'is valid with a business email domain' do
          business_user.email = 'john.doe@company.com'
          expect(business_user).to be_valid
        end
      end

      context 'when email is from a personal domain' do
        it 'is invalid with a personal email domain' do
          business_user.email = 'john.doe@gmail.com'
          expect(business_user).not_to be_valid
          expect(business_user.errors[:email]).to include("You must use a business email")
        end
      end
    end
  end
end
