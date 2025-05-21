module BxBlockWishlist
  class WishlistsController < ApplicationController

    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token
    before_action :current_user
    before_action :wishlist_params, only: %i[toggle_wishlist]

    def index
      # find all wishlists for the current user and order them by creation date
      wishlists = Wishlist.where(account_id: @current_user).order(created_at: :DESC)
      if wishlists.present?
        render json: WishlistSerializer.new(wishlists).serializable_hash, status: :ok
      else
        return render json: { message: "You haven't added any items yet" }, status: :unprocessable_entity
      end
    end

    def create
      begin
        # create a new wishlist with item_id and account_id
        wishlist = Wishlist.new(item_id: wishlist_params[:item_id], account_id: @current_user.id)
        # save the wishlist and render success message along with wishlist data
        if wishlist.save
          render :json => {'data'=> wishlist, 'message' => ['Item added to Wishlist Successfully']},
                 status: :created
        else
          # if the wishlist couldn't be saved, render errors
          render json: { errors: wishlist.errors },
          status: :unprocessable_entity
        end

      # if there's an exception during wishlist creation, render the error message
      rescue Exception => e
        render json: { errors: e.message },
          status: :unprocessable_entity
      end
    end

    def destroy
      begin
        wishlist = Wishlist.find(params[:id])

        # if the wishlist exists, delete it and render success message
        if wishlist.present?
          # Delete wishlist
          if wishlist.destroy
            render :json => {'message' => ['Item Deleted From Wishlist Successfully']},
                   status: :ok
          end
        else
          # if the wishlist doesn't exist, render error message
          return render :json => {'message' => ['Wishlist Not Found']}, status: :bad_request
        end

      # if there's an exception during wishlist deletion, render the error message
      rescue => e
        return render json: { errors: [
          { wishlist: "Couldn't find Wishlist with id #{params[:id]}" }
        ] }, status: :bad_request
      end
    end

    private

    def wishlist_params
      params.require(:wishlist).permit(:item_id)
    end

    # get the current user from token
    def current_user
      return unless @token
      @current_user ||= AccountBlock::Account.find(@token.id)
    end
  end
end
