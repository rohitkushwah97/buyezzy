module BxBlockSupport
  class StaticPagesController < ApplicationController
    before_action :set_static_page, only: [:show, :update, :destroy]

    def index
      @static_pages = StaticPage.all.where(status: true)

      render json: @static_pages
    end

    def show
      render json: @static_page
    end

    def delete_static_pages
       if params[:ids].present?
        pages = StaticPage.where(id: params[:ids])
        if pages.destroy_all
          render json: { message: 'Pages deleted successfully' }, status: :ok
        end
      else
        render json: { error: 'No IDs provided' }, status: :unprocessable_entity
      end
    end

    private

    def set_static_page
      @static_page = StaticPage.find_by(id: params[:id],status: true)
    end

  end
end