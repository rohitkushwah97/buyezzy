module BxBlockCatalogue
  class ReviewSerializer < BuilderBase::BaseSerializer
    attributes :id, :title, :rating, :description, :review_type, :is_approved, :order_item_id, :created_at, :updated_at, :helpful_count

    attribute :review_images do |object|
      if object.review_images.attached?
        object.review_images.map { |image| "#{ENV['BASE_URL']}#{Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)}" }
      end
    end

    attribute :helpful do |object, params|
      current_account = params[:current_account]
      {
        helpful_by_current_user: current_account.present? ? object.helpful_by?(current_account) : false,
        data: object.helpful_reviews.find_by(customer_id: current_account&.id)
      }
    end

    attribute :catalogue do |obj|
      BxBlockCatalogue::Catalogue.find_by(id: obj&.catalogue_id)
    end

    attribute :reviewer do |obj|
      AccountBlock::AccountSerializer.new(AccountBlock::Account.find_by(id: obj&.reviewer_id))
    end

    attribute :account do |obj|
      AccountBlock::Account.find_by(id: obj&.account_id)
    end

    attribute :order_item do |obj|
      BxBlockShoppingCart::OrderItem.find_by(id: obj.order_item_id)
    end
  end
end
