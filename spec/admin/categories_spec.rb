require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  render_views
  let(:admin_user) { create(:admin_user) }
  let!(:category) { create(:category) }

  before do
    sign_in admin_user
  end

  describe "GET index" do
    it "displays a list of categories" do
      category2 = create(:category, name: Faker::Lorem.word + Faker::Lorem.word)
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'filters by category name' do
      get :index, params: { q: { name_cont: category.name } }
      expect(assigns(:categories)).to include(category)
    end

    it 'filters by subcategories' do
      sub_category = create(:sub_category, category: category)
      get :index, params: { q: { sub_categories_id_eq: sub_category.id } }
      expect(assigns(:categories)).to include(category)
    end

    it 'filters by mini categories' do
      mini_category = create(:mini_category, sub_category: create(:sub_category, category: category))
      get :index, params: { q: { mini_categories_id_eq: mini_category.id } }
      expect(assigns(:categories)).to include(category)
    end

    it 'filters by micro categories' do
      micro_category = create(:micro_category, mini_category: create(:mini_category, sub_category: create(:sub_category, category: category)))
      get :index, params: { q: { micro_categories_id_eq: micro_category.id } }
      expect(assigns(:categories)).to include(category)
    end

    it 'filters by created_at' do
      get :index, params: { q: { created_at_gteq_datetime: category.created_at.strftime("%Y-%m-%d 00:00:00"), created_at_lteq_datetime: category.created_at.strftime("%Y-%m-%d 23:59:59") } }
      expect(assigns(:categories)).to include(category)
    end

    it 'filters by updated_at' do
      get :index, params: { q: { updated_at_gteq_datetime: category.updated_at.strftime("%Y-%m-%d 00:00:00"), updated_at_lteq_datetime: category.updated_at.strftime("%Y-%m-%d 23:59:59") } }
      expect(assigns(:categories)).to include(category)
    end
    
  end

  describe "GET new" do
    it "displays the new category form" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET show' do
    it 'renders the show template and assigns the category' do
      sub_category = create(:sub_category, category: category)
      mini_category = create(:mini_category, sub_category: sub_category)
      micro_category = create(:micro_category, mini_category: mini_category)
      custom_field = create(:custom_field, fieldable: category)
      sub_custom_field = create(:custom_field, fieldable: sub_category)
      mini_custom_field = create(:custom_field, fieldable: mini_category)
      micro_custom_field = create(:custom_field, fieldable: micro_category)


      get :show, params: { id: category.id }

      expect(response).to render_template(:show)
      expect(assigns(:category).sub_categories.last.custom_fields).to include(sub_custom_field)
      expect(assigns(:category).sub_categories.last.mini_categories.last.custom_fields).to include(mini_custom_field)
      expect(assigns(:category).sub_categories.last.mini_categories.last.micro_categories.last.custom_fields).to include(micro_custom_field)
      expect(assigns(:category)).to eq(category)
      expect(assigns(:category).created_at).to eq(category.created_at)
      expect(assigns(:category).custom_fields).to include(custom_field)
      expect(assigns(:category).sub_categories).to include(sub_category)
      expect(assigns(:category).sub_categories.last.mini_categories).to include(mini_category)
      expect(assigns(:category).sub_categories.last.mini_categories.last.micro_categories).to include(micro_category)
    end
  end

end
