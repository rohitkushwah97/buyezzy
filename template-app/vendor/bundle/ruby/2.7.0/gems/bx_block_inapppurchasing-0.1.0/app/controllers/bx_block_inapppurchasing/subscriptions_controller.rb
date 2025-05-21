module BxBlockInapppurchasing
  class SubscriptionsController < ApplicationController
    
    def store_transaction_details
      Subscription.create!(subscription_params)
      render json: { message: 'Successfully stored details' }, status: :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: format_active_record_errors(e.record.errors) }, status: :unprocessable_entity
    end

    private

    def subscription_params
      params.require(:subscription).permit(:transaction_id, :platform, :receipt)
    end

    def format_active_record_errors(errors)
      errors.full_messages.join(', ')
    end

  end
end
