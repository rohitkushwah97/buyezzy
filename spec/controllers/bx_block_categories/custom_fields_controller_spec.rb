require 'rails_helper'

RSpec.describe BxBlockCategories::CustomFieldsController, type: :controller do

  before(:all) do
    @account = create(:account)
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
  end

  let(:category) { create(:category) }
  let(:category_null) { create(:category) }
  let!(:sub_category) { create(:sub_category, name: 'Test Subcategory', category: category) }
  let!(:mini_category) { create(:mini_category, name: 'Test Mini Category', sub_category: sub_category) }
  let!(:micro_category) { mini_category.micro_categories.create(name: 'Test Micro Category') }
  let!(:custom_field_category) { create(:custom_field, fieldable: category) }
  let!(:custom_field_micro_category) { create(:custom_field, fieldable: micro_category) }

  describe 'GET index' do
    it 'returns a list of custom fields' do
      get :index, params: { category_id: category.id , token: @token}
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"].size).to eq(BxBlockCategories::CustomField.all.count)
    end
  end

  describe 'GET show_custom_fields' do
    context 'when category is present' do
      it 'returns custom fields for the category' do
        get :show_custom_fields, params: { category_id: category.id , token: @token}
        expect(response).to have_http_status(:ok)
        # expect(JSON.parse(response.body)["data"]).to include(custom_field_category.id.to_s)
        # expect(JSON.parse(response.body)["data"]).to include(custom_field_category.name)
      end
    end

    context 'when microcategory is present' do
      it 'returns custom fields for the microcategory' do
        get :show_custom_fields, params: { token: @token, category_id: category.id, micro_category_id: micro_category.id }
        expect(response).to have_http_status(:ok)
        # expect(JSON.parse(response.body)["data"]).to eq(custom_field_micro_category.id.to_s)
        # expect(JSON.parse(response.body)["data"]).to eq(custom_field_micro_category.name)
      end
    end

    context 'when neither category nor microcategory is present' do
      it 'returns not found' do
        get :show_custom_fields, params: { category_id: category_null.id , token: @token}
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Custom fields don't exist for this category or microcategory.")
      end
    end
  end
end
