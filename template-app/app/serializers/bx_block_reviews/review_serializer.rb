module BxBlockReviews
  class ReviewSerializer < BuilderBase::BaseSerializer
    attributes(:id, :title, :description, :internship_id, :account_id, :reviews_type, :reviewer_id, :prompt_manager_id, :rating, :version_id, :created_at)

    attribute :reviewer do |object|
      AccountBlock::AccountSerializer.new(object.reviewer).serializable_hash unless object.anonymous
    end
  end
end
