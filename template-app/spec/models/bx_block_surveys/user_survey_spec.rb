require 'rails_helper'

RSpec.describe BxBlockSurveys::UserSurvey, type: :model do

	describe 'associations' do
    it { should belong_to(:account).class_name('AccountBlock::Account') }
    it { is_expected.to have_many(:submissions) }
  end
end