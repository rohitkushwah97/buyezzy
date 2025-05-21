module BxBlockLikeAPost
  class LikePostSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer
    attributes(:id, :account_id, :post_id, :created_at, :updated_at, :account, :post)
  end
end
