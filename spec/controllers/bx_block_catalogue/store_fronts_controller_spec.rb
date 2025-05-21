require 'rails_helper'

RSpec.describe BxBlockCatalogue::StoreFrontsController, type: :controller do
  let(:valid_account_id) { 1 }
  let(:invalid_account_id) { 999 }
  let(:valid_category_id) { 1 }
before do
  @account = FactoryBot.create(:account) 
  @account_b = FactoryBot.create(:account, user_type: 'buyer') 
  @account1 = FactoryBot.create(:account, user_type: "seller")
  @token = BuilderJsonWebToken.encode(@account.id, token_type: 'login') 
  @token_1 = BuilderJsonWebToken.encode(@account1.id, token_type: 'login') 
  @category = FactoryBot.create(:category) 
  @brand = FactoryBot.create(:brand)
  @catalogue = FactoryBot.create(:catalogue, category_id: @category.id, brand_id: @brand.id, seller_id: @account1.id, status: true) 
  @catalogue_without_review = FactoryBot.create(:catalogue, category_id: @category.id, brand_id: @brand.id, seller_id: @account1.id, status: true) 
  @review = FactoryBot.create(:review)
end

  describe 'GET #index' do
    it 'returns a list of latest product' do    
      get :latest_product, params: { token: @token, account_id: @account.id}
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #index' do
    it 'returns a list of seller catalogue' do    
      get :index, params: { token: @token, account_id: @account1.id}
      expect(response).to have_http_status(:ok)
    end
     it 'return a list by category' do
      get :index, params: { token: @token, account_id: @account1.id, category_id: @category.id}
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe 'GET #return by popular_product' do
    it 'returns a list of popular products' do
      get :popular_product, params: { token: @token, account_id: @account.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #average_rating_for_product' do
    it 'returns average rating for a product' do
      review = FactoryBot.create(:review, catalogue: @catalogue, rating: 4) 
      get :average_rating_for_product, params: { token: @token, account_id: @account.id, catalogue_id: @catalogue.id }
      expect(response).to have_http_status(:ok)
    end
    it ' not found product' do
      get :average_rating_for_product, params: { token: @token, account_id: @account.id, catalogue_id: 'invalid_id' }
      expect(response).to have_http_status(:not_found)
    end

    it ' when reviews not product' do
      get :average_rating_for_product, params: { token: @token, account_id: @account.id, catalogue_id: @catalogue_without_review.id }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #average_rating_for_seller' do
    it 'returns the average rating for the seller' do
      get :average_rating_for_seller, params: { token: @token, account_id: @account1.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #ratings_percentage' do
    it 'returns the correct ratings percentage for the seller' do
      review = FactoryBot.create(:review, account: @account1, rating: 4) 
      get :ratings_percentage, params: { token: @token, account_id: @account1.id } 
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #latest_review_for_seller' do
    it 'returns the latest reviews for the seller' do
      review_accountb = FactoryBot.create(:review, review_type: 'seller', reviewer_id: @account_b.id, account_id: @account1.id )
      get :latest_review_for_seller, params: { token: @token_1, account_id: @account1.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'][0]['attributes']['name']).to eq(@account1.full_name)
      expect(JSON.parse(response.body)['data'][0]['attributes']['created_at']).to eq(@account1.created_at.strftime("%d/%m/%y"))

    end
  end

  describe '#list_reviews GET' do
    context 'when reviews not found' do
      it 'not_found response' do
        get :list_reviews, params: {catalogue_id: 0}
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when reviews present' do
      it 'revert with  a successful response' do
        @review.update(catalogue_id: @catalogue.id)
        get :list_reviews, params: {catalogue_id: @catalogue.id}
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when reviews with seller type' do
      it 'returns a successful response with seller reviews' do
        @review.update(catalogue_id: @catalogue.id, review_type: 'seller')
        get :list_reviews, params: {catalogue_id: @catalogue.id}
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when reviews with product type' do
      it 'return a successful response with product reviews' do
        @review.update(catalogue_id: @catalogue.id, review_type: 'product')
        get :list_reviews, params: {catalogue_id: @catalogue.id}
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#ratings_percentage_for_product GET' do
    context 'when product not found' do
      it 'returns a not_found res' do
        get :ratings_percentage_for_product, params: {catalogue_id: 0}
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when reviews are present there' do
      it 'return a successful response' do
        @review.update(catalogue_id: @catalogue.id)
        get :ratings_percentage_for_product, params: {catalogue_id: @catalogue.id}
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when reviews are found' do
      it 'returns a successful responses' do
        get :ratings_percentage_for_product, params: {catalogue_id: @catalogue_without_review.id}
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#latest_review_for_product GET' do
    context 'when product not found' do
      it 'returns a not found response' do
        get :latest_review_for_product, params: {catalogue_id: 0}
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when reviews are there' do
      it 'returns successful response' do
        @review.update(catalogue_id: @catalogue.id)
        get :latest_review_for_product, params: {catalogue_id: @catalogue.id}
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when reviews found' do
      it 'returns a not found response' do
        get :latest_review_for_product, params: {catalogue_id: @catalogue_without_review.id}
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end