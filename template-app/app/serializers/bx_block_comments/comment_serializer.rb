# frozen_string_literal: true

module BxBlockComments
  class CommentSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer
    attributes(:id, :account_id, :commentable_id, :commentable_type, :commentable, :comment, :created_at, :updated_at)

    attribute :is_liked do |obj, params|
      is_like = false
      like = params[:current_user].present? ? BxBlockLike::Like.where(like_by_id: params[:current_user].id, likeable_id: obj.id, likeable_type: "BxBlockComments::Comment") : ""
      is_like = true if like.present?
      is_like
    end

    attribute :likes_count do |obj|
      BxBlockLike::Like.where(likeable_id: obj.id, likeable_type: "BxBlockComments::Comment").count
    end

    attribute :account do |obj|
      AccountBlock::AccountSerializer.new(obj.account).serializable_hash[:data]
    end

  end
end
