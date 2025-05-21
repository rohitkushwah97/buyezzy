require 'rails_helper'

RSpec.describe BxBlockSurveys::InternUserGenericQuestion, type: :model do

  describe 'associations' do
    it { should belong_to(:business_user).class_name('AccountBlock::BusinessUser') }
    it { should belong_to(:internship).class_name('BxBlockNavmenu::Internship') }
  end

  describe 'database' do
    it { should have_db_column(:business_user_id).of_type(:integer) }
    it { should have_db_column(:internship_id).of_type(:integer) }
  end

end
