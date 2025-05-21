module BxBlockCatalogue
	class HelpfulReviewsController < ApplicationController
		before_action :validate_json_web_token
		before_action :find_user
		before_action :find_review, only: [:create, :destroy]

		def create
			helpful_review = @review.helpful_reviews.new(customer: @account)

			if helpful_review.save
				render json: { message: 'Marked as helpful', helpful_count: @review.helpful_count }, status: :ok
			else
				render json: { error: 'Could not mark as helpful' }, status: :unprocessable_entity
			end
		end

		def destroy
			helpful_review = @review.helpful_reviews.find_by(customer: @account)

			if helpful_review&.destroy
				render json: { message: 'Unmarked as helpful', helpful_count: @review.helpful_count }, status: :ok
			else
				render json: { error: 'Could not unmark as helpful' }, status: :unprocessable_entity
			end
		end

		private

		def find_review
			@review = BxBlockCatalogue::Review.find(params[:review_id])
		end

		def find_user
			@account = AccountBlock::Account.find_by(id: @token.id, user_type: 'buyer')
			if @account.nil?
				return render json: { message: 'Account does not exist' },
				status: :not_found
			end
		end
	end
end