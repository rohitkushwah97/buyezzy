require 'rails_helper'

RSpec.describe Admin::ContactUsController, type: :controller do
  render_views
 

  before do
    @admin = FactoryBot.create(:admin_user)
    @contact = FactoryBot.create(:contact)
    sign_in @admin
    @contacts = create_list(:contact, 2)
    @no_image = 'No image yet'
  end

  describe 'GET #index' do
    it 'returns a success index response' do
      @contacts.last.image.detach
      get :index
      expect(response).to render_template(:index)
       @contacts.each do |contact|
          expect(response.body).to include(contact.title)
          expect(response.body).to include(contact.description)
          expect(response.body).to include(contact.email)
          expect(response.body).to include(contact.contact_type)
          expect(response.body).to include(@no_image)
      end
    end
  end

  describe 'GET #show' do

    it 'displays "No image yet" when the image is not attached' do
      @contact.image.detach
      get :show, params: { id: @contact.id }
      expect(response).to render_template(:show)
      expect(response.body).to include(@no_image)
    end

    it 'returns a success show response' do
      get :show, params: { id: @contact.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'returns a success new response' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
