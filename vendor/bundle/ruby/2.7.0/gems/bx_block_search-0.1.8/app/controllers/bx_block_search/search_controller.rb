# frozen_string_literal: true

module BxBlockSearch
  class SearchController < ApplicationController
    def posts
      posts = current_user
              .posts
              .where('description ILIKE :search', search: "%#{search_params[:query]}%")
              .order(id: 'desc')
      render json: ::BxBlockPosts::PostSerializer.new(posts).serializable_hash, status: :ok
    end

    def users
      accounts = ::AccountBlock::Account
                 .where(activated: true)
                 .where.not(id: current_user.id)
                 .where('first_name ILIKE :search or last_name ILIKE :search or email ILIKE :search',
                 search: "%#{search_params[:query]}%")
      render json: ::BxBlockSearch::UserSerializer.new(accounts,
        params: { current_user_id: current_user.id }, meta: { message: 'List of users.'
                }).serializable_hash, status: :ok
    end

    def comments
      comments = current_user
                 .comments
                 .where('comment ILIKE :search', search: "%#{search_params[:query]}%")
                 .order(id: 'desc')
      render json: ::BxBlockComments::CommentSerializer.new(comments,
        meta: { success: true, message: 'Comment details.' },
        params: { current_user_id: current_user.id }).serializable_hash, status: :ok
    end

    def chats
      chats = current_user
              .chats
              .where('name ILIKE :search', search: "%#{search_params[:query]}%")
      render json: ::BxBlockChat::ChatSerializer.new(chats, meta: {}).serializable_hash, status: :ok
    end

    def messages
      chat_ids = BxBlockChat::AccountsChatsBlock.where(account_id: current_user.id).pluck(:id)
      messages =  ::BxBlockChat::ChatMessage
                  .where(chat_id: chat_ids)
                  .where('message ILIKE :search', search: "%#{search_params[:query]}%")
      render json: BxBlockChat::ChatMessageSerializer.new(messages, meta: {}).serializable_hash, status: :ok
    end

    private

    def search_params
      params.permit(:query, :attachment_type)
    end
  end
end
