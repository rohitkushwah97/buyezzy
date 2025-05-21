module BxBlockTermsandconditions
  class SellerStaticPagesController < ApplicationController
    before_action :set_seller_static_page, only: [:show]

    def index
      @seller_static_pages = SellerStaticPage.all.where(status: true)

      render json: @seller_static_pages
    end

    def show
      render json: @seller_static_page
    end

    def delete_static_pages
       if params[:ids].present?
        pages = SellerStaticPage.where(id: params[:ids])
        if pages.destroy_all
          render json: { message: 'Pages deleted successfully' }, status: :ok
        end
      else
        render json: { error: 'No IDs provided' }, status: :unprocessable_entity
      end
    end

    private

    def set_seller_static_page
      @seller_static_page = SellerStaticPage.find(params[:id])
    end

    # def seller_static_page_params
    #   params.require(:seller_static_page).permit(:title, :content, :status)
    # end
  end
end