require 'rails_helper'

RSpec.describe BxBlockRecommendation::Recommendation, type: :model do

	describe 'associations' do
		it { should belong_to(:intern_user).class_name('AccountBlock::InternUser') }
		it { should belong_to(:internship).class_name('BxBlockNavmenu::Internship')}
	end
end
