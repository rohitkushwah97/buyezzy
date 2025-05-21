require 'rails_helper'

RSpec.describe Admin::MicroCategoriesController, type: :controller do
  render_views
  let!(:category) { create(:category, name: 'Test Category') }
  let!(:sub_category) { create(:sub_category, name: 'Test Subcategory', category: category) }
  let!(:mini_category) { create(:mini_category, name: 'Test Mini Category', sub_category: sub_category) }
  let!(:micro_category) { mini_category.micro_categories.create(name: 'Test Micro Category') }

  before do
    @admin_user = create(:admin_user)
    sign_in @admin_user
  end

  describe "GET new" do
    it "displays the new micro category form" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    it 'creates a new micro category and redirects to the category show page' do
      expect {
        post :create, params: { micro_category: { name: 'New Micro Category', mini_category_id: mini_category.id } }
      }.to change(BxBlockCategories::MicroCategory, :count).by(1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_category_path(category))
    end

    it 'invalid params create a new micro category and redirects to the micro show page' do
      expect {
        post :create, params: { micro_category: { name: 'New Micro Category', parent_id: category.id } }
      }.to change(BxBlockCategories::MicroCategory, :count).by(0)

      expect(response).to render_template(:new)
    end
  end

  describe 'PUT update' do
    it 'updates the attributes of a micro category and redirects to the category show page' do
      updated_name = 'Updated Micro Category'

      put :update, params: { id: micro_category.id, micro_category: { name: updated_name, parent_id: category.id, mini_category_id: mini_category.id } }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_category_path(category))
      expect(micro_category.reload.name).to eq(updated_name)
    end

    it 'invalid params update the attributes of a micro category and redirects to the micro edit page' do
      updated_name = 'Updated Micro Category'

      put :update, params: { id: micro_category.id, micro_category: { name: updated_name, parent_id: category.id, mini_category_id: nil } }

      expect(response).to render_template(:edit)
    end
  end

  describe 'Delete Destroy' do
    it 'Destroy the attributes of a micro category and redirects to the category show page' do

      delete :destroy, params: { id: micro_category.id }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_category_path(category))
      # expect(mini_category.reload.name).to eq(updated_name)
    end
  end

  describe 'GET show' do
    it 'renders the show template and assigns the micro category' do
      custom_field = create(:custom_field, fieldable: micro_category)


      get :show, params: { id: micro_category.id }

      expect(response).to render_template(:show)
      expect(assigns(:micro_category)).to eq(micro_category)
      expect(assigns(:micro_category).custom_fields).to include(custom_field)
    end
  end
end
