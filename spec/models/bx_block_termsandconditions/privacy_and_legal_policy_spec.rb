require 'rails_helper'

RSpec.describe BxBlockTermsandconditions::PrivacyAndLegalPolicy, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
end
