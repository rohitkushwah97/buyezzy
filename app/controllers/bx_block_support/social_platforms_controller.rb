module BxBlockSupport
  class SocialPlatformsController < ApplicationController
    before_action :set_social_platform, only: [:show, :update, :destroy]

    def index
      @social_platforms = SocialPlatform.all

      render json: @social_platforms.map { |platform| social_platform_data(platform) }
    end

    def show
      render json: social_platform_data(@social_platform)
    end

    private

    def set_social_platform
      @social_platform = SocialPlatform.find(params[:id])
    end

    def social_platform_data(platform)
      social_icon_url = if platform.social_icon.attached?
        ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(platform.social_icon, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(platform.social_icon, only_path: true)
      end
      
      {
        id: platform.id,
        social_media: platform.social_media,
        social_media_url: platform.social_media_url,
        social_icon:  social_icon_url
      }
    end

  end
end