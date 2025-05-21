module BxBlockCatalogue
  class ReviewsController < ApplicationController
    include BxBlockCatalogue::CatalogueSearch

    before_action :validate_json_web_token, except: [:customer_rating_and_reviews]
    before_action :check_review, only: [:show, :destroy]
    before_action :check_catalogue, only: [:index, :customer_rating_and_reviews]
    before_action :check_user, only: [:create, :update]
    before_action :check_valid_params, only: [:user_review_listing]
    before_action :get_seller, only: [:user_review_listing, :seller_happiness_indicator]

    #create review for product, seller, adn delivery
    def create
      create_review(:product) if params[:product].present?
      create_review(:seller) if params[:seller].present?
      create_review(:delivery) if params[:delivery].present?
    end

    def update
      update_review_params = extract_review_params(:review).reject! { |_, value| value.nil? }
      
      @review = Review.find_by(id: params[:id])
      render json: { errors: "Review not found" }, status: :not_found and return if @review.nil?
      
      HelpfulReview.create(review_id: params[:id], customer: @account) if update_review_params[:helpful]

      if @review.update(update_review_params.except(:helpful))
        render json: ReviewSerializer.new(@review, params: { current_account: @account }).serializable_hash, status: :ok
      else
        render json: { errors: format_activerecord_errors(@review.errors) }, status: :unprocessable_entity
      end
    end

    def customer_rating_and_reviews
      per_page = params[:per_page].presence || 10
      page = params[:page].presence || 1

      if params[:review_type].present?
        reviews = @catalogue.review_and_ratings.approved_reviews.where(review_type: params[:review_type]).order(created_at: :desc)
      else
        reviews = @catalogue.review_and_ratings.approved_reviews.order(created_at: :desc)
      end
      customer_ratings = seller_rating_percentage(reviews)
      average_rating = average_rating(reviews).round(1)
      total_rating = total_rating(reviews)
      total_reviews = reviews.count

      reviews = reviews.where("title IS NOT NULL AND title != '' OR description IS NOT NULL AND description != ''")

      if reviews.present?
        reviews = paginate_catalogues(reviews, page, per_page)
      end

      account = AccountBlock::Account.find_by(id: params[:account_id])

      serializer = ReviewSerializer.new(reviews, params: { current_account: account }).serializable_hash

      render json: { customer_ratings: customer_ratings, average_rating: average_rating, total_rating: total_rating, reviews: serializer, total_reviews: total_reviews }, status: :ok
    end

    def show
      render json: ReviewSerializer.new(@review, serialization_options).serializable_hash, status: :ok
    end

    def index
      serializer = ReviewSerializer.new(@catalogue.review_and_ratings.approved_reviews, serialization_options)

      render json: serializer, status: :ok
    end

    def user_review_listing
      serializer = ReviewSerializer.new(@seller.review_and_ratings.approved_reviews, serialization_options)
      render json: serializer, status: :ok
    end

    def buyer_review_listing
      buyer = AccountBlock::Account.find_by(id: @token.id, user_type: 'buyer')
      render json: {error: "buyer not found"}, status: :unprocessable_entity and return unless buyer

      find_reviews = Review.where(order_item_id: params[:order_item_id], reviewer_id: buyer.id)

      render json: ReviewSerializer.new(find_reviews), status: :ok
    end

    def seller_happiness_indicator
      seller_review_collection = @seller.review_and_ratings.order(created_at: :desc).group_by(&:review_type)

      if seller_review_collection.present?
        response = {}
        reviews_filtered = []

        seller_review_collection.each do |type, reviews|
          next unless reviews.present?

          average_rating = average_rating(reviews).round(1)
          review_percentages = seller_rating_percentage(reviews)

          reviews_to_display = if params[:filter_by].present?
                         reviews_filtered = reviews.select { |review| params[:filter_by].map(&:to_i).include?(review.rating) }
                         add_reviewer_name(reviews_filtered)
                       else
                         add_reviewer_name(reviews)
                       end

          response[type] = {
            reviews: reviews_to_display,
            meta: {
              type: type,
              average_rating: average_rating,
              seller_review_percentages: review_percentages,
              seller_total_rating: total_rating(reviews)
            }
          }
        end

        render json: response, status: :ok
      else
        render json: { message: "No reviews found for this seller" }, status: :not_found
      end
    end

    def destroy
      if @review.destroy
        render json: {message: "Review destroyed successfully"}, status: :ok
      end
    end

    private

    def check_valid_params
      valid_review_types = %w[seller delivery product]
      unless valid_review_types.include?(params[:review_type])
        return render json: { error: { message: 'Invalid review_type' } }, status: :unprocessable_entity
      end
    end

    def check_user
      @account = AccountBlock::Account.find_by(id: @token.id)
      if @account.nil?
        return render json: { message: 'Account does not exist' },
               status: :not_found
      end
    end

    def create_review(type)
      review = BxBlockCatalogue::Review.new(extract_review_params(type).merge(reviewer_id: @account.id).except(:helpful))
      if review.save
        render json: {
          review: ReviewSerializer.new(review).serializable_hash,
          message: "Review added successfully"
        }, status: :created
      else
        return render json: { errors: format_activerecord_errors(review.errors) },
               status: :unprocessable_entity
      end
    end

    def check_review
      @review = Review.find_by(id: params[:id], is_approved: true)
      unless @review.present?
        render json: {
          message: "Review with id #{params[:id]} doesn't exists"
        }, status: :not_found
      end
    end

    def check_catalogue
      @catalogue = Catalogue.find_by(id: params[:catalogue_id])
      unless @catalogue.present?
        render json: {
          message: "Reviews not found with Catalogue id #{params[:catalogue_id]}"
        }, status: :not_found
      end
    end

    def get_seller      
      @seller = AccountBlock::Account.find_by(id: @token.id,user_type: 'seller')
      unless @seller.present?
        render json: {
          message: "Seller not found"
        }, status: :not_found
      end
    end
    
    def serialization_options
      { params: { host: request.protocol + request.host_with_port } }
    end

    def extract_review_params(type)
      review_params = params[type] || ActionController::Parameters.new
      review_attributes = {
        rating: review_params[:rating],
        title: review_params[:title],
        description: review_params[:description],
        catalogue_id: review_params[:catalogue_id],
        review_type: review_params[:review_type],
        review_images: review_params[:review_images],
        account_id: review_params[:account_id],
        order_item_id: review_params[:order_item_id],
        helpful: review_params[:helpful]
      }
      review_attributes
    end

    def add_reviewer_name(reviews)
      reviews.map do |review|
        reviewer_name = AccountBlock::Account.find_by(id: review.reviewer_id)&.full_name
        reviewer_images = review.review_images.map { |image| "#{ENV['BASE_URL']}#{Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)}" }
        review.as_json.merge(reviewer_name: reviewer_name, review_images: reviewer_images)
      end
    end
  end
end
