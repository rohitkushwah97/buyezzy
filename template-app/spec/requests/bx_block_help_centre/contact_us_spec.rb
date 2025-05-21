require 'rails_helper'

RSpec.describe BxBlockHelpCentre::ContactUsController, type: :controller do
  describe 'POST #create' do
    let(:issue_type) { BxBlockHelpCentre::IssueType.create(name: 'Technical Issue') }
    
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          contact_us: {
            full_name: 'John Doe',
            email: 'john.doe@example.com',
            issue_type_id: issue_type.id,
            inquiry_details: 'I need help with my account.'
          }
        }
      end

      it 'creates a new ContactUs inquiry' do
        expect {
          post :create, params: valid_attributes
        }.to change(BxBlockHelpCentre::ContactUs, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq('message' => 'Inquiry submitted successfully.')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          contact_us: {
            full_name: '',
            email: '',
            issue_type_id: nil,
            inquiry_details: ''
          }
        }
      end

      it 'does not create a new ContactUs inquiry' do
        expect {
          post :create, params: invalid_attributes
        }.not_to change(BxBlockHelpCentre::ContactUs, :count)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include(
          "Full name can't be blank",
          "Email can't be blank",
          "Issue type must exist",
          "Inquiry details can't be blank"
        )
      end
    end
  end
end