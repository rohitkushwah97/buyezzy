require 'rails_helper'

RSpec.describe BxBlockSurveys::InternUserGenericAnswer, type: :model do
  describe 'associations' do
    it { should belong_to(:account).class_name('AccountBlock::Account') }
    it { should belong_to(:internship).class_name('BxBlockNavmenu::Internship') }
  end

  describe 'database' do
    it { should have_db_column(:account_id).of_type(:integer) }
    it { should have_db_column(:internship_id).of_type(:integer) }
  end
end
