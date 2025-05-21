require 'rails_helper'

RSpec.describe Admin::ReviewsController, type: :controller do
  render_views
  let!(:admin_user) { create(:admin_user) }
  let!(:account) { create(:account, user_type: 'buyer') }
  let!(:seller) { create(:account, user_type: 'seller') }
  let!(:catalogue) { create(:catalogue, seller: seller) }
  let!(:img_name) {"Sample.jpg"}
  let!(:review) { create(:review, account_id: seller.id, reviewer_id: account.id, review_images: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", img_name))]) }
  let!(:review_2) { create(:review) }
  let(:valid_attributes) do
      {
        title: "recipe is nice",
        description: "dummy description",
        rating: 5,
        catalogue_id: catalogue.id,
        reviewer_id: account.id,
        review_type: 'product',
        account_id: seller.id,
        review_images: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", img_name))]
      }
  end

  before do
    sign_in admin_user
  end

  describe "Get#index" do
    it "listing review and ratings" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "Get#show" do
    it "show review and rating" do
      get :show, params: {id: review.id}
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(img_name)
      expect(response.body).to include(review.account_id.to_s)
    end

    it "show no seller review" do
      get :show, params: {id: review_2.id}
      expect(response).to have_http_status(200)
      expect(response.body).to include("No seller added")
    end
  end

  describe "GET #edit" do
    it "renders the edit template" do
      get :edit, params: { id: review.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
      expect(response.body).to include(img_name)
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "NEW#review_and_rating" do
    it 'new review and ratings' do
      post :new, params: { review: valid_attributes}
      expect(response).to have_http_status :success
    end
  end

  describe "Create#Create Review and Rating" do
    it "should create review and ratings" do
      post :create, params: {review: valid_attributes}
      expect(response).to have_http_status(302)
    end
  end

  describe "Update#Update Review and Rating" do
    it "should update review and ratings" do
      patch :update, params: {review: valid_attributes, id: review.id}
      expect(response).to have_http_status(302)
    end
  end

  describe "INDEX#filters" do
    it "filters by comment" do  
      get :index, params: { filter: { title: review.title } }  
      expect(response).to have_http_status(:success)
    end

    it "filters by rating" do  
      get :index, params: { filter: { rating: review.rating } }  
      expect(response).to have_http_status(:success)
    end

    it "filters by recipe" do  
      get :index, params: { filter: { catalogue: review.catalogue_id } }  
      expect(response).to have_http_status(:success)
    end

    it "filters by account" do  
      get :index, params: { filter: { account: review.account_id } }  
      expect(response).to have_http_status(:success)
    end
  end

  describe 'CSV Export' do
    it 'returns CSV data' do
      # get :index, format: :csv
      # expect(response).to have_http_status(:success)
    end
  end
end
