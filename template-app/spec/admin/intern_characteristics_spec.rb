require 'rails_helper'
 
RSpec.describe Admin::InternCharacteristicsController, type: :controller do
  render_views
  
  before(:each) do
    admin =  FactoryBot.create(:admin)
    sign_in admin
  end

  describe 'GET#index' do
  	context 'get all interncaharacteristics' do
  		let!(:intern_characteristic) {create(:intern_characteristic)}
	  	it 'should return list of interncaharacteristics' do
	  		get :index
	  		expect(response).to have_http_status(200)
        expect(response.body).to be_present
	  	end
	  end
  end

end
