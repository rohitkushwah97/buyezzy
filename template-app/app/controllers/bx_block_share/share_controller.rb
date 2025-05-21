# frozen_string_literal: true

require "net/http"
require "uri"
require "twitter"

module BxBlockShare
  # share controller
  class ShareController < ApplicationController
    def twitter
      path = twitter_params[:url]
      twit_path = "https://twitter.com/intent/tweet?text=#{path}"
      render json: {message: twit_path}, status: :ok
    end

    # create controller
    def create
      share = ::BxBlockShare::Share.create!(share_params.merge!({account_id: current_user.id}))
      share.upload_documents(params[:data][:documents]) if share.persisted? && params[:data][:documents].present?

      render json: ShareSerializer.new(share, meta: {message: "Share."}, params: {host: request.base_url}).serializable_hash,
        status: :ok
    end

    def index
      shared = ::BxBlockShare::Share
        .where("shared_to_id = :search or account_id = :search", search: current_user.id)
        .order(created_at: :desc)
      render json: ShareSerializer.new(
        shared, meta: {message: "Share."}, params: {host: request.base_url}
      ).serializable_hash, status: :ok
    end

    def shared_with_me
      shared = ::BxBlockShare::Share
        .where("shared_to_id = :search", search: current_user.id)
        .order(created_at: :desc)
      render json: ShareSerializer.new(
        shared, meta: {message: "Share."}, params: {host: request.base_url}
      ).serializable_hash, status: :ok
    end

    private

    def twitter_params
      params.permit(:url)
    end

    def share_params
      params
        .require(:data)
        .permit(:shared_to_id, :post_id)
    end
  end
end
