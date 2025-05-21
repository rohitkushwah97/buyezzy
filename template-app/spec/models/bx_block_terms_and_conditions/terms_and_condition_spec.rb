require 'rails_helper'

RSpec.describe BxBlockTermsAndConditions::TermsAndCondition, type: :model do
  
  describe "Terms And Condition" do

    context "associations" do
      it { is_expected.to have_many(:user_terms_and_conditions).class_name('BxBlockTermsAndConditions::UserTermAndCondition').dependent(:destroy) }
    end

    context "validations" do
    	it { should validate_presence_of(:account_type).on(:update) }
      it { should validate_presence_of(:description).on(:update) }
    end
  end

  context "enums" do
    it { should define_enum_for(:account_type).with_values(%i(Intern Business)) }
  end
  
end