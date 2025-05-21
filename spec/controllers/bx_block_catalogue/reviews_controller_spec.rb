require 'rails_helper'

RSpec.describe BxBlockCatalogue::ReviewsController, type: :controller do

  before do
    @account = FactoryBot.create(:account, user_type: "buyer")
    @seller = FactoryBot.create(:account, user_type: "seller")
    @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login')
    @token_1 = BuilderJsonWebToken.encode(@seller.id, token_type: 'login')
    @review = create(:review, is_approved: true)
    @catalogue = create(:catalogue, seller: @seller )
    @order_status = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'On Going')
    @order = create(:shopping_cart_order, customer: @account, order_status: @order_status)
    @order_item = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order)
    @review_1 = create(:review, account: @seller, rating: 3, review_type: 'seller', catalogue: @catalogue, is_approved: true, reviewer_id: @account.id, order_item_id: @order_item.id )
    @review_2 = create(:review, account: @seller, rating: 4, review_type: 'delivery', catalogue: @catalogue, is_approved: true, reviewer_id: @account.id, order_item_id: @order_item.id )

  end


  let(:valid_params) {
    { product: { review_type: 'product', title: Faker::Lorem.paragraph, description: Faker::Lorem.paragraph(sentence_count: 3), rating: Faker::Number.between(from: 1, to: 5), catalogue_id: @catalogue.id, order_item_id: @order_item.id },token: @token }
  }

  describe "GET #index" do
    it "return review listing" do
      get :index, params: {token: @token, catalogue_id: @catalogue.id}
      expect(response).to have_http_status(:ok)
    end

    it "doesn't return review listing" do
      get :index, params: {token: @token, catalogue_id: 0}
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["message"]).to eq("Reviews not found with Catalogue id 0")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new review" do
        expect {
          post :create, params: valid_params
        }.to change(BxBlockCatalogue::Review, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["message"]).to eq("Review added successfully")
      end

      it "doesn't create a new review" do
        valid_params[:product][:rating] = ''
        post :create, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to eq(["Rating can't be blank", "Rating is not a number"])
      end
    end
  end

  describe 'GET #show' do
    it 'show review' do
      get :show, params: { token: @token , id: @review.id, is_approved: true}
      expect(response).to have_http_status(:ok)
    end

    it "doesn't return review" do
      get :show, params: {token: @token, id: 0}
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["message"]).to eq("Review with id 0 doesn't exists")
    end
  end

  describe 'Delete #destroy' do
    it 'destroy review' do
      delete :destroy, params: { token: @token , id: @review.id, is_approved: true}
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Review destroyed successfully")
    end
  end

  describe 'GET #user_review_listing' do
    context "return user review's listing" do
      it 'renders a response with product reviews' do
        @review.update(catalogue_id: @catalogue.id)
        # @seller.review_and_ratings << @review_2
        get :user_review_listing, params: { seller: { seller_id: @seller.id }, token: @token_1, catalogue_id: @catalogue.id, review_type: 'delivery' }
        expect(response).to have_http_status(:ok)
      end

      it 'renders an invalid params response' do
        get :user_review_listing, params: { token: @token, review_type: 'productt' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

   describe 'GET #seller_happiness_listing' do
    context "return seller happiness listing" do
      it "returns the seller happiness indicator" do
      @seller.review_and_ratings << @review_1
      @seller.review_and_ratings << @review_2

      params = { filter_by: [3,4], token: @token_1 }

      get :seller_happiness_indicator, params: params

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      expect(json_response).to include('seller', 'delivery')

      type1_data = json_response['seller']
      expect(type1_data['meta']).to have_key('seller_review_percentages')
      expect(type1_data['reviews']).to be_a(Array)

      type2_data = json_response['delivery']
      expect(type2_data['meta']).to have_key('average_rating')
      expect(type2_data['reviews']).to be_a(Array)
    end

    it "returns the seller happiness indicator without filter" do
      @seller.review_and_ratings << @review_1

      get :seller_happiness_indicator, params: {token: @token_1 }

      expect(response).to have_http_status(:ok)

      json_response1 = JSON.parse(response.body)
      expect(json_response1).to include('seller')

      type1_data = json_response1['seller']
      expect(type1_data['reviews'][0]).to have_key('review_images')
      expect(type1_data['meta']).to have_key('seller_review_percentages')
      expect(type1_data['reviews']).to be_a(Array)
    end

    it "returns a not_found response when no reviews are found" do

      get :seller_happiness_indicator, params: { token: @token_1 }

      expect(response).to have_http_status(:not_found)

      json_response = JSON.parse(response.body)
      expect(json_response).to include('message')
      expect(json_response['message']).to eq("No reviews found for this seller")
    end
    end
  end

  describe "POST #update" do
    context "update with valid params" do
      before do
        @update_params = {review: {title: "updated title", description: "updated desc"}}
      end
      it "update a new review" do
        patch :update, params: @update_params.merge(id: @review_1.id, token: @token)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["id"]).to eq(@review_1.id.to_s)
      end

      it "doesn't update a new review" do
        @update_params[:review][:rating] = ''
        patch :update, params: @update_params.merge(id: @review_1.id, token: @token)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("Rating can't be blank")
      end
      
      it "update a new review with helpful option" do
        patch :update, params: @update_params.merge(id: @review_1.id, token: @token, helpful: true)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["attributes"]["helpful_count"]).to eq(@review_1.helpful_count)
      end

      it "review not exist" do
        patch :update, params: @update_params.merge(id: 00, token: @token)
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["errors"]).to eq("Review not found")
      end

      it "review image above 5 mb" do
        patch :update, params: @update_params.merge(
          id: @review_1.id,
          token: @token,
          review: { review_images: [fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'Sampleimage5mb.jpg'))] }
          )
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("Review Failed to upload image. only png, jpg, jpeg format is allowed and maximum size is 5mb")
      end
    end
  end

  describe "GET #buyer_review_listing" do
    before do 
      @buyer = FactoryBot.create(:account, user_type: "buyer")
      @token_1 = BuilderJsonWebToken.encode(@buyer.id, token_type: 'login')
      @catalogue_1 = create(:catalogue, seller: @seller)
      @order_status_1 = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'On Going')
      @order_1 = create(:shopping_cart_order, customer: @buyer, order_status: @order_status_1)
      @order_item_1 = create(:shopping_cart_order_item, catalogue: @catalogue_1, order: @order_1)
      @review_3 = create(:review, reviewer_id: @buyer.id, account_id: @seller.id, rating: 3, review_type: 'seller', catalogue: @catalogue_1, order_item_id: @order_item_1.id)
      @order_item_1.reload
    end

    context "getting buyer reviews" do
      it "success result from response" do
        get :buyer_review_listing, params: {token: @token_1, order_item_id: @order_item_1.id}
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data'][0]['id']).to eq(@review_3.id.to_s)
        expect(JSON.parse(response.body)['data'][0]['attributes']['order_item']['id']).to eq(@order_item_1.id)
      end
    end
  end

  describe "GET #customer_rating_and_reviews" do
    context "when review type is provided" do
      it "returns the reviews of specific type" do
        get :customer_rating_and_reviews, params: {catalogue_id: @catalogue.id, review_type: 'seller'}
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['total_reviews']).to eq(@catalogue.review_and_ratings.where(review_type: 'seller').approved_reviews.count)
        expect(JSON.parse(response.body)['reviews']['data'].first['attributes']['review_type']).to eq('seller')
      end
    end

    context "when review type is not provided" do
      it "returns the all reviews of catalogue" do
        get :customer_rating_and_reviews, params: {catalogue_id: @catalogue.id}
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['reviews']).to have_key('data')
      end
    end

    context "when current account selected helpful" do
      it "returns the all reviews of catalogue and helpful record" do
        get :customer_rating_and_reviews, params: { catalogue_id: @catalogue.id, account_id: @account.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['reviews']['data'][0]["attributes"]).to have_key('helpful')
      end
    end
  end

end