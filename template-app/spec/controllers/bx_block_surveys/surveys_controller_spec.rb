require 'rails_helper' 
require 'simplecov'
RSpec.describe BxBlockSurveys::SurveysController, type: :request do

	describe "Delete#remove_interncharacteristic" do
		context 'remove adata' do 
			let(:intern_user) { FactoryBot.create(:intern_user, activated: true) }
			let(:business_user) { FactoryBot.create(:business_user, activated: true) }
			let(:intern_token) { get_token(intern_user) }
			let(:business_token) { get_token(business_user) }
			let!(:intern_characteristic) { create(:intern_characteristic) }
			it 'should delete all interncharacteristic' do
				get bx_block_surveys_remove_interncharacteristics_path, headers: { token: intern_token }
				expect(response).to have_http_status(200)
				expect(BxBlockSurveys::InternCharacteristic.count).to eq(0)
			end
		end
	end
end