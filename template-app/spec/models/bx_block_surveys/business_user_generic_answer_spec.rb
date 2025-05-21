require 'rails_helper'

RSpec.describe BxBlockSurveys::BusinessUserGenericAnswer, type: :model do
  describe 'associations' do
    it { should belong_to(:business_user).class_name('AccountBlock::BusinessUser') }
  end
end
