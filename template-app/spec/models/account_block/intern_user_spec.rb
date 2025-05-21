require 'rails_helper'

RSpec.describe AccountBlock::InternUser, type: :model do
  subject(:intern_user) do
    described_class.new(
      email: "john.doe@business.com",
      password: "Password1!",
      country_flag: "india.png"
    )
  end

  describe "Callbacks" do
    it "before_create" do
      response = intern_user.run_callbacks(:create)
      expect(response).to eq(true)
    end
  end

  describe 'validations' do
    describe 'age validation' do
      context 'when age is valid' do
        it 'is valid age of intern group user' do
          intern_user.date_of_birth = Date.today-18.years
          expect(intern_user).to be_valid
        end
      end

      context 'when email is from a personal domain' do
        it 'is invalid with a personal email domain' do
          intern_user.date_of_birth = Date.today
          expect(intern_user).not_to be_valid
          expect(intern_user.errors[:date_of_birth]).to include("should be over 16 years old.")
        end
      end

      context 'when phone number is valid' do
        it 'will check phone number' do
          intern_user.full_phone_number = "9176970638424"
          expect(intern_user).not_to be_valid
          expect(intern_user.errors[:full_phone_number]).to include("Please enter a valid phone number.")
        end
      end
    end
  end
end
