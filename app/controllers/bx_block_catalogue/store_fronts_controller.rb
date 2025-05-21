module BxBlockCatalogue
  class StoreFrontsController < ApplicationController
    before_action :validate_json_web_token
    skip_before_action :validate_json_web_token, only: [:list_reviews, :average_rating_for_product, :ratings_percentage_for_product, :latest_review_for_product]
    before_action :set_account, except: [:average_rating_for_product, :latest_review_for_product, :ratings_percentage_for_product, :list_reviews]
    before_action :filter_by_category_and_ratings, only: [:index]
    before_action :popular_catalog, only: [:popular_product]
    before_action :find_product, only: [:average_rating_for_product, :ratings_percentage_for_product, :latest_review_for_product]

    def index      
      render json: StoreFrontSerializer.new(@catalogues), status: :ok
    end

    def latest_product
      latest_catalog = @account.catalogues.order(created_at: :desc)
      render json: StoreFrontSerializer.new(latest_catalog), status: :ok
    end

    def popular_product
      render json: StoreFrontSerializer.new(@popular_products), status: :ok
    end

    def average_rating_for_seller
      average_rating = @account.review_and_ratings.average(:rating)
      render json: {average_rating: average_rating}, status: :ok
    end

    def average_rating_for_product
      average_rating = @product.review_and_ratings.average(:rating)
      if average_rating.present?
        render json: { average_rating: average_rating }, status: :ok
      else
        render json: { message: "No average rating found" }, status: :not_found
      end
    end

    def ratings_percentage
      ratings = @account.review_and_ratings
      seller_total_rating = @account.review_and_ratings.pluck(:rating).sum
      total_ratings = ratings.count

      percentages = {}
      (1..5).each do |rating|
        rating_count = ratings.where(rating: rating).count
        percentages[rating] = (rating_count.to_f / total_ratings.to_f) * 100
      end

      render json: {seller_review_percentages: percentages, seller_total_rating: seller_total_rating}, status: :ok
    end

    def ratings_percentage_for_product
      ratings = @product.review_and_ratings
      if ratings.present?
        product_total_rating = ratings.sum(:rating)
        total_ratings = ratings.count
        percentages = {}
        (1..5).each do |rating|
          rating_count = ratings.where(rating: rating).count
          percentages[rating] = (rating_count.to_f / total_ratings.to_f) * 100
        end
        render json: { product_review_percentages: percentages, product_total_rating: product_total_rating }, status: :ok
      else
        render json: { message: "Rating Not Found" }, status: :not_found
      end
    end

    def latest_review_for_seller
      ratings = @account.review_and_ratings.order(created_at: :desc).limit(2)
      render json: StoreFrontListingSerializer.new(ratings), status: :ok
    end

    def latest_review_for_product
      latest_reviews = @product.review_and_ratings.order(created_at: :desc)
      if latest_reviews.present?
        render json: ReviewSerializer.new(latest_reviews), status: :ok
      else
        render json: { message: 'Latest Ratings not Found' }, status: :not_found
      end
    end

    def list_reviews
      review_collection = BxBlockCatalogue::Review.where(catalogue_id: params[:catalogue_id]).group_by(&:review_type)
      if review_collection.present?
        seller_reviews = {reviews: review_collection['seller'], meta: {type: 'seller', average_rating: average_rating(review_collection, 'seller'), seller_review_percentages: seller_rating_percentage('seller'), seller_total_rating: seller_total_rating('seller')  }} if review_collection['seller'].present?
        catalogue_reviews = {reviews: review_collection['product'], meta: {type: 'product', average_rating: average_rating(review_collection, 'product'), seller_review_percentages: seller_rating_percentage('product'), seller_total_rating: seller_total_rating('product')  }} if review_collection['product'].present?
        delivery_reviews = {reviews: review_collection['delivery'], meta: {type: 'delivery', average_rating: average_rating(review_collection, 'delivery'), seller_review_percentages: seller_rating_percentage('delivery'), seller_total_rating: seller_total_rating('delivery')  }} if review_collection['delivery'].present?

        render json: {seller: seller_reviews, product: catalogue_reviews, delivery: delivery_reviews}, status: :ok
      else
        render json: { message: "No reviews found with this catalogue id #{params[:category_id]}" }, status: :not_found
      end
    end

    private

    def find_product
      @product = Catalogue.find_by(id: params[:catalogue_id])
      if @product.nil?
        render json: { message: "Product does not exist with id #{params[:catalogue_id]}" },
               status: :not_found
      end
    end

    def average_rating(review_collection, type)
      (0...review_collection.count).to_a.each do |record|
        reviews = BxBlockCatalogue::Review.where(review_type: type)
        average_rating = reviews.average(:rating).to_f.round(1)
        return average_rating rescue 0
      end
    end

    # def calculate_rating_percent(review_collection)
    #   reviews = BxBlockCatalogue::Review.where(catalogue_id: params[:catalogue_id])
    #   if reviews.present?
    #     product_total_rating = reviews.sum(:rating)
    #     total_ratings = reviews.count
    #     percentages = {}
    #     (1..5).each do |rating|
    #       rating_count = reviews.where(rating: rating).count
    #       percentages[rating] = (rating_count.to_f / total_ratings.to_f) * 100
    #     end

    #     (0...review_collection.count).to_a.each do |record|
    #         type = review_collection[record][:meta][:type]
    #         if type == 'product'
    #           review_collection[record][:meta][:product_review_percentage] = percentages
    #           review_collection[record][:meta][:product_total_rating] = product_total_rating
    #         end
    #       end
    #   end
    # end

    def seller_rating_percentage(type)
      ratings = BxBlockCatalogue::Review.where(catalogue_id: params[:catalogue_id], review_type: type)
      total_ratings = ratings.count
      percentages = {}
      (1..5).each do |rating|
        rating_count = ratings.where(rating: rating).count
        percentages[rating] = (rating_count.to_f / total_ratings.to_f) * 100
      end
      return percentages
    end

    def seller_total_rating(type)
      ratings = BxBlockCatalogue::Review.where(catalogue_id: params[:catalogue_id], review_type: type)
      return ratings.sum(:rating)
    end

    def set_account     
      @account = AccountBlock::Account.find_by(id: params[:account_id])
      unless @account
        render json: {
          message: "Account with id #{params[:account_id]} doesn't exist"
        }, status: :not_found
      end
    end

    def popular_catalog
      @popular_products = @account.catalogues
          .joins(:review_and_ratings)
          .group('catalogues.id')
          .order('AVG(review_and_ratings.rating) DESC')
    end

    def filter_by_category_and_ratings
      @catalogues =  @account.catalogues
      if params[:category_id].present?
        @catalogues = @account.catalogues.where(category_id: params[:category_id])
      elsif params[:rating].present?
        catalogue_id = @account.catalogues.joins(:review_and_ratings).pluck(:id)
        catalogue_ids = Review.where(catalogue_id: catalogue_id, rating: params[:rating]).pluck(:catalogue_id)
        @catalogues = Catalogue.where(id: catalogue_ids)
      else
        @catalogues = @account.catalogues
      end
    end
  end
end
