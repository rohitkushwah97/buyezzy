require 'rails_helper'

RSpec.describe Admin::SubCategoriesController, type: :controller do
  render_views
  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @category = create(:category)
    @sub_category = create(:sub_category, category: @category)
  end

  describe 'GET show' do
    it 'renders the show template and assigns the sub category' do
      custom_field = create(:custom_field, fieldable: @sub_category)


      get :show, params: { id: @sub_category.id }

      expect(response).to render_template(:show)
      expect(assigns(:sub_categories)).to eq(@sub_category)
      expect(assigns(:sub_categories).custom_fields).to include(custom_field)
      expect(assigns(:sub_categories).category).to eq(@category)
    end
  end

  describe "index page" do
    it "displays a list of subcategories" do
      sub_category2 = create(:sub_category,name: Faker::Lorem.word + Faker::Lorem.word, category: @category)

      get :index

      expect(response).to have_http_status(:success)
      expect(response.body).to include(@sub_category.name)
      expect(response.body).to include(sub_category2.name)
    end
  end

  describe "GET new" do
    it "displays the new sub category form" do
      get :new

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    it "creates a new subcategory" do
      sub_category_params = { name: "New Subcategory", parent_id: @category.id }

      expect {
        post :create, params: { sub_category: sub_category_params }
      }.to change(BxBlockCategories::SubCategory, :count).by(1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_category_path(@category))
    end
  end

  describe "PUT update" do
    it "updates the attributes of a subcategory" do
      updated_name = "Updated Subcategory"

      put :update, params: { id: @sub_category.id, sub_category: { name: updated_name, parent_id: @sub_category.category.id } }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_category_path(@sub_category.category))
      expect(@sub_category.reload.name).to eq(updated_name)
    end

    it "invalid updates the attributes of a subcategory" do

      put :update, params: { id: @sub_category.id, sub_category: { name: '', parent_id: @sub_category.category.id } }

      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE destroy" do
    it "deletes a subcategory" do
      expect {
        delete :destroy, params: { id: @sub_category.id }
      }.to change(BxBlockCategories::SubCategory, :count).by(-1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_category_path(@sub_category.category))
    end
  end
end
