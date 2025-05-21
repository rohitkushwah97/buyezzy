require 'rails_helper'

RSpec.describe BxBlockProfile::CareerInterest, type: :model do

  let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
  let(:industry) { FactoryBot.create(:industry, name: "IT") }
  let(:role) { FactoryBot.create(:role, name: "Software Developer", industry_id: industry.id) }
  let!(:career_interest) { FactoryBot.create(:career_interest, intern_user_id: intern_user.id, industry_id: industry.id, role_id: role.id)  }

  context 'Association' do
    it { should belong_to(:intern_user).class_name('AccountBlock::InternUser').with_foreign_key('intern_user_id') }
    it { should belong_to(:industry).class_name('BxBlockCategories::Industry').with_foreign_key('industry_id') }
    it { should belong_to(:role).class_name('BxBlockCategories::Role').with_foreign_key('role_id') }
  end

  context "validations" do
    let!(:career_interest2) { FactoryBot.build(:career_interest, intern_user_id: intern_user.id, industry_id: industry.id, role_id: role.id)  }

    it 'raise uniqueness validation error' do
      career_interest2.valid?
      expect(career_interest2.errors.full_messages).to include("Intern user has already been taken industry_role combination.")
    end
  end
end