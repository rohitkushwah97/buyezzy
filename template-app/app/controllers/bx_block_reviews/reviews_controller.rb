module BxBlockReviews
  class ReviewsController < ApplicationController
    before_action :current_user, :authenticate_account
    before_action :validate_review_type, only: [:create]
    before_action :find_internship, only: [:create]
    before_action :load_account, only: [:index]
    before_action :load_review, only: [:update]

    def index
      reviews = BxBlockReviews::Review.find_by_account_id(@account.id) # @account.reviews
      render json: ReviewSerializer.new(reviews).serializable_hash,
        status: :ok
    end

    def show_feedback
      reviews_type = params[:reviews_type]

      case reviews_type
      when "internship"
        review_data = BxBlockReviews::Review.where(internship_id: params[:internship_id], reviewer_id: current_user.id, reviews_type: params[:reviews_type])
      when "chatbox"
        review_data = BxBlockReviews::Review.where(reviews_type: params[:reviews_type], reviewer_id: current_user.id, internship_id: params[:internship_id], version_id: params[:version_id])
      when "business_feedback"
        review_data = BxBlockReviews::Review.where(reviews_type: params[:reviews_type], reviewer_id: current_user.id, internship_id: params[:internship_id])
      else
        return render json: { error: "Invalid review type" }, status: :unprocessable_entity
      end

      if review_data.blank?
        return render json: { error: "No reviews found" }, status: :not_found
      end

      render json: BxBlockReviews::ReviewSerializer.new(review_data).serializable_hash, status: :ok
    end

    def create
      review = BxBlockReviews::Review.new(review_params)
      review.account_id = current_user.id
      review.reviewer_id = @internship.business_user_id if (@internship.present? && params[:review][:reviews_type] == "internship") || params[:review][:reviews_type] == "chatbox"
      prompt_manager = BxBlockChat::PromptManager.last
      if prompt_manager.present? && params[:review][:reviews_type] == "chatbox"
        review.prompt_manager_id = prompt_manager.id
      end
      case review.reviews_type
      when "internship"
        return unless validate_internship_review(review)
      when "chatbox"
        return unless validate_chatbox_review(review)
      when "business_feedback"
        return unless validate_business_feedback(review)
      else
        return render json: { error: "Invalid review type" }, status: :unprocessable_entity
      end

      if review.save
        render json: BxBlockReviews::ReviewSerializer.new(review).serializable_hash, status: :created
      else
        render json: ErrorSerializer.new(review).serializable_hash, status: :unprocessable_entity
      end
    end

    def update
      return if @review.nil?

      review_attributes = jsonapi_deserialize(params)
      service = BxBlockReviews::Update.new(@review, review_attributes)
      result = service.execute
      if result.persisted?
        render json: ReviewSerializer.new(result).serializable_hash,
          status: :ok
      else
        render json: ErrorSerializer.new(result).serializable_hash,
          status: :unprocessable_entity
      end
    end

    private

    def validate_review_type
      allowed_review_types = ["internship", "chatbox", "business_feedback"]
      unless allowed_review_types.include?(params[:review][:reviews_type])
        render json: { error: "Invalid reviews_type" }, status: :unprocessable_entity
      end
    end

    def find_internship
      @internship = BxBlockNavmenu::Internship.find_by(id: params[:review][:internship_id])
      render json: { error: "internship is not present with same id" }, status: :unprocessable_entity if @internship.nil?
    end

    def review_params
      params.require(:review).permit(:title, :description, :reviews_type, :internship_id, :account_id, :reviewer_id, :prompt_manager_id, :rating, :version_id)
    end

    def load_account
      @account = AccountBlock::Account.find(params[:account_id])
      if @account.nil?
        render json: {message: "Account does not exist"},
          status: :not_found
      end
    end

    def load_review
      @review = Review.find(params[:id])
      if @review.nil?
        render json: {message: "Review does not exist"},
          status: :not_found
      end
    end

    def validate_internship_review(review)
      if review.internship_id.nil?
        render json: { error: "Internship ID is required for internship reviews" }, status: :unprocessable_entity
        return false
      end

      existing_review = BxBlockReviews::Review.find_by(internship_id: review.internship_id, account_id: review.account_id, reviews_type: "internship")
      if existing_review.present?
        render json: { error: "Internship review already exists" }, status: :unprocessable_entity
        return false
      end

      true
    end

    def validate_chatbox_review(review)
      missing_fields = []
      missing_fields << "rating" if review.rating.nil?
      missing_fields << "version_id" if review.version_id.nil?

      if missing_fields.any?
        render json: { error: "Missing required fields: #{missing_fields.join(', ')}" }, status: :unprocessable_entity
        return false
      end

      true
    end

    def validate_business_feedback(review)
      if review.internship_id.nil?
        render json: { error: "Internship ID is required for business feedback" }, status: :unprocessable_entity
        return false
      end

      unless current_user.type == "BusinessUser"
        render json: { error: "Only business users can give business-to-intern feedback" }, status: :forbidden
        return false
      end

      true
    end

  end
end
