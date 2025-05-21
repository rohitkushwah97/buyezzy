require 'rails_helper'

RSpec.describe BxBlockCatalogue::CatalogueContentsController, type: :controller do

  before do
    @account = FactoryBot.create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @catalogue = create(:catalogue)
    @custom_field = create(:custom_field)
    @catalogue_content = create(:catalogue_content, catalogue: @catalogue,custom_field: @custom_field )

    @category = FactoryBot.create(:category)
    @sub_category = FactoryBot.create(:sub_category)
    @mini_category = FactoryBot.create(:mini_category)
    @micro_category = FactoryBot.create(:micro_category)

    @custom_field1 = FactoryBot.create(:custom_field, field_name: 'Field1', fieldable: @category)
    @custom_field2 = FactoryBot.create(:custom_field, field_name: 'Field2', fieldable: @sub_category)
    @custom_field3 = FactoryBot.create(:custom_field, field_name: 'Field3', fieldable: @mini_category)
    @custom_field4 = FactoryBot.create(:custom_field, field_name: 'Field4', fieldable: @micro_category)

    @catalogue_content1 = FactoryBot.create(:catalogue_content, custom_field: @custom_field1, catalogue: @catalogue)
    @catalogue_content2 = FactoryBot.create(:catalogue_content, custom_field: @custom_field2, catalogue: @catalogue)
    @catalogue_content3 = FactoryBot.create(:catalogue_content, custom_field: @custom_field3, catalogue: @catalogue)
    @catalogue_content4 = FactoryBot.create(:catalogue_content, custom_field: @custom_field4, catalogue: @catalogue)
  end


  describe 'GET index' do
    it 'returns a list of catalogue contents' do

      get :index, params: { catalogue_id: @catalogue.id , token: @token}
      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)['data'].size).to eq(5)
    end
  end

  describe 'POST create' do
    it 'creates catalogue contents' do
      content_params = [
        { custom_field_id: @custom_field.id, value: 'Value 1', custom_field_name: @custom_field.field_name }
      ]

      post :create, params: { catalogue_id: @catalogue.id, catalogue_contents_entries: content_params , token: @token}
      expect(response).to have_http_status(:created)

      expect(JSON.parse(response.body)['data'].size).to eq(1)
      expect(JSON.parse(response.body)['data'][0]['attributes']['value']).to eq(content_params[0][:value])
    end
  end

  describe 'PUT update_catalogue_contents' do
    it 'updates catalogue contents' do


      updated_content_params = [
        { id: @catalogue_content.id, custom_field_id: @catalogue_content.custom_field_id, value: 'Updated Value', custom_field_name: 'Updated Field' }
      ]

      put :update_catalogue_contents, params: { catalogue_id: @catalogue.id, catalogue_contents_entries: updated_content_params, token: @token }
      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)['data'].size).to eq(1)

      updated_content = BxBlockCatalogue::CatalogueContent.find_by(id: @catalogue_content.id)
      expect(updated_content.value).to eq('Updated Value')
      expect(updated_content.custom_field_name).to eq('Updated Field')
    end
  end

  describe 'DELETE delete_catalogue_contents' do
    it 'deletes catalogue contents' do

      contents_to_delete = create_list(:catalogue_content, 3, catalogue: @catalogue, custom_field: @custom_field)

      content_ids_to_delete = contents_to_delete.map(&:id)

      delete :delete_catalogue_contents, params: { catalogue_id: @catalogue.id, ids: content_ids_to_delete , token: @token}
      expect(response).to have_http_status(:ok)

      remaining_contents = BxBlockCatalogue::CatalogueContent.where(id: content_ids_to_delete)
      expect(remaining_contents).to be_empty
    end
  end

  describe 'GET fetch_custom_field_filters' do
    it 'returns custom field values filtered by categories' do
      get :fetch_custom_field_filters, params: {
        category_ids: [@category.id],
        sub_category_ids: [@sub_category.id],
        mini_category_ids: [@mini_category.id],
        micro_category_ids: [@micro_category.id],
        token: @token
      }

      expect(response).to have_http_status(:ok)

      result = JSON.parse(response.body)
      expect(result['custom_field_values']['Field1']).to match_array([@catalogue_content1.value])
      expect(result['custom_field_values']['Field2']).to match_array([@catalogue_content2.value])
      expect(result['custom_field_values']['Field3']).to match_array([@catalogue_content3.value])
      expect(result['custom_field_values']['Field4']).to match_array([@catalogue_content4.value])
    end
  end
end
