module AccountBlock
  class AccountSerializer < BuilderBase::BaseSerializer
    attributes(
     :first_name,
     :last_name, 
     :company_or_store_name,
     :email, 
     :full_name,
     :full_phone_number,
     :phone_number, 
     :country_code, 
     :user_type, 
     :language,
     :activated, 
     :created_at, 
     :updated_at, 
     :device_id, 
     :unique_auth_id,
     :current_order)

    attribute :country_code do |object|
      country_code_for object
    end

    attribute :phone_number do |object|
      phone_number_for object
    end

    attribute :profile_picture do |object|
      if object.profile_picture.attached?
        ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.profile_picture, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.profile_picture, only_path: true)
      end
    end

    attribute :seller_rating do |object|
      reviews = object.review_and_ratings.approved_reviews.where(review_type: 'seller')
      total_count = reviews.count
      if reviews.present?
        {
          average_rating: average_rating(reviews).round(1),
          total_reviews: total_count
        }
      end
    end

    attribute :document_status do |object|
      get_document_status(object)
    end

    attribute :first_time_login do |object|
      set_first_time_login(object)
    end

    class << self
      private

      def country_code_for(object)
        return nil unless Phonelib.valid?(object.full_phone_number)
        Phonelib.parse(object.full_phone_number).country_code
      end

      def phone_number_for(object)
        return nil unless Phonelib.valid?(object.full_phone_number)
        Phonelib.parse(object.full_phone_number).raw_national
      end

      def average_rating(reviews)
        total_reviews = reviews.count
        return 0 if total_reviews.zero?

        total_rating = reviews.sum(&:rating)
        total_rating.to_f / total_reviews
      end

      def get_document_status(account)
        @seller_documents = account.seller_documents
        if @seller_documents.blank?
          "No documents uploaded"
        elsif @seller_documents.all?(&:approved?)
          "Your document has been verified"
        elsif @seller_documents.any?(&:rejected?)
          rejected_documents = @seller_documents.select(&:rejected?).map(&:document_name)
          "Rejected: #{rejected_documents.join(', ')}"
        else
          "Your Document verification is in progress"
        end
      end

      def set_first_time_login(account)
        if account.last_visit_at.nil? && @seller_documents.present? && @seller_documents.all?(&:approved?)
          account.update(last_visit_at: Time.now)
          return true
        else
          return false
        end
      end

    end
  end
end
