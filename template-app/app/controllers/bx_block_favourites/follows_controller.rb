module BxBlockFavourites
  class FollowsController < ApplicationController

    USER_NOT_EXISTS = "User Doesn't Exists"
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token, :authenticate_account, :check_account_activated

    def create
      user = AccountBlock::Account.find_by(id: params[:user_id])
      if user.present?
        return render json: { message: "You Can't Follow Yourself" }, status: :unprocessable_entity if user.id == current_user.id
        follow_check = check_follow(user.id)
        unless follow_check.present?
          @current_user.follows.create(follow_id: user.id)
          render json: { message: 'Started Following' }, status: :ok
        else
          render json: { message: 'Already Following' }, status: :ok
        end
      else
        render json: { error: USER_NOT_EXISTS }, status: :not_found
      end
    end

    def unfollow
      user = AccountBlock::Account.where(id: params[:user_id]).first
      if user.present?
        follow_check = check_follow(user.id)
        if follow_check.present?
          follow_check.destroy
          render json: { message: 'Unfollowing' }, status: :ok
        else
          render json: { message: 'Please Follow To Unfollow' }, status: :ok
        end
      else
        render json: { error: USER_NOT_EXISTS }, status: :not_found
      end
    end

    def remove_follower_from_followers
      user = AccountBlock::Account.where(id: params[:user_id]).first
      if user.present?
        follow = BxBlockFavourites::Follow.where("follow_id = ? AND account_id = ?",current_user.id, user.id ).last
        if follow.present?
          follow.destroy
          render json: { message: 'follower remove from your account' }
        else
          render json: { message: 'follow record not present' }
        end
      else
        render json: { error: USER_NOT_EXISTS }
      end
    end

    def current_user_followings
      page = (params[:page] || 1).to_i
      per_page = (params[:per_page] || 10).to_i
      follows = current_user.follows.order(updated_at: :desc).page(page).per(per_page)

      if follows.present?
        render json: {
          data: BxBlockFavourites::FollowSerializer.new(follows).serializable_hash[:data],
          meta: {
            pagination: {
              current_page: follows.current_page,
              per_page: follows.limit_value,
              total_pages: follows.total_pages,
              total_items: follows.total_count
            }
          }
        }, status: :ok
      else
        render json: { data: [] }, status: :ok
      end
    end

    def current_user_followers
      page = (params[:page] || 1).to_i
      per_page = (params[:per_page] || 10).to_i
      follows = BxBlockFavourites::Follow.where(follow_id: current_user.id).order(updated_at: :desc).page(page).per(per_page)

      if follows.present?
        render json: {
          data: BxBlockFavourites::UserFollowerSerializer.new(follows).serializable_hash[:data],
          meta: {
            pagination: {
              current_page: follows.current_page,
              per_page: follows.limit_value,
              total_pages: follows.total_pages,
              total_items: follows.total_count
            }
          }
        }, status: :ok
      else
        render json: { data: [] }, status: :ok
      end
    end

    private
    
    def check_follow(user_id)
      follow = current_user.follows.find_by(follow_id: user_id)
      follow
    end
  end
end
