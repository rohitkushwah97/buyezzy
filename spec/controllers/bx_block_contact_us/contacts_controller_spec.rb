require 'rails_helper'

RSpec.describe BxBlockContactUs::ContactsController, type: :controller do
 

  describe 'POST#Create contact' do
    context 'Create Contact' do
      it 'should create contact' do 
        expect {
          post :create, params: {email: "test@gmail.com", description: "test", title: 'dummy', contact_type: "complaint", image: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "Sample.jpg"))}
        }.to change(BxBlockContactUs::Contact, :count).by(1)
        expect(response).to have_http_status :created
        parsed_response_2 = JSON.parse(response.body)
        expect(parsed_response_2['data']['attributes']).to have_key('image')
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end

      it 'should not create contact' do 
        post :create, params: {email: " "}
        expect(response.body).to eq("{\"errors\":[{\"contact\":[\"Title can't be blank\",\"Email can't be blank\",\"Contact type can't be blank\",\"Description can't be blank\"]}]}")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
