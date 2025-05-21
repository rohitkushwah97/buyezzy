require 'rails_helper'

RSpec.describe Admin::MiniCategoriesController, type: :controller do
  render_views
  let!(:category) { create(:category, name: 'Test Category') }
  let!(:sub_category) { create(:sub_category, name: 'Test Subcategory', category: category) }
  let!(:mini_category) { create(:mini_category, name: 'Test Mini Category', sub_category: sub_category) }

  before do
    @admin_user = create(:admin_user)
    sign_in @admin_user
  end

  describe 'POST create' do
    it 'creates a new mini category and redirects to the category show page' do
      expect {
        post :create, params: { mini_category: { name: 'New Mini Category', sub_category_id: sub_category.id } }
      }.to change(BxBlockCategories::MiniCategory, :count).by(1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_category_path(category))
    end

    it ' invalid params to create a new mini category and redirects to the category show page' do
      expect {
        post :create, params: { mini_category: { name: 'New Mini Category',parent_id: category.id, sub_category_id: '' } }
      }.to change(BxBlockCategories::MiniCategory, :count).by(0)

      expect(response).to render_template(:new)
    end
  end

  describe 'PUT update' do
    it 'updates the attributes of a mini category and redirects to the category show page' do
      updated_name = 'Updated Mini Category'

      put :update, params: { id: mini_category.id, mini_category: { name: updated_name, sub_category_id: sub_category.id} }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_category_path(category))
      expect(mini_category.reload.name).to eq(updated_name)
    end

    it 'invalid params update the attributes of a mini category and redirects to the category show page' do
      updated_name = 'Updated Mini Category'

      put :update, params: { id: mini_category.id, mini_category: { name: updated_name, sub_category_id: nil } }

      expect(response).to render_template(:edit)
    end
  end

  describe 'GET show' do
    it 'renders the show template and assigns the mini category' do
      custom_field = create(:custom_field, fieldable: mini_category)


      get :show, params: { id: mini_category.id }

      expect(response).to render_template(:show)
      expect(assigns(:mini_category)).to eq(mini_category)
      expect(assigns(:mini_category).custom_fields).to include(custom_field)
      expect(assigns(:mini_category).sub_category.name).to eq(sub_category.name)
    end
  end

  describe "GET new" do
    it "displays the new mini category form" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'Delete destroy' do
    it 'Destroy the attributes of a mini category and redirects to the category show page' do

      delete :destroy, params: { id: mini_category.id }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_category_path(category))
      # expect(mini_category.reload.name).to eq(updated_name)
    end
  end


end
